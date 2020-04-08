#!/usr/bin/env python
from __future__ import print_function
import argparse, os, sys, subprocess, time

from multiprocessing import Pool, Value

def submit_job_unpack(args):
    return submit_job(*args)

def submit_job(instance,index):
    instance.submit_job(index)

def init(args):
    global n_finished
    n_finished = args

class JobManager(object):
    def __init__(self, options, workdir="/nfs/dust/cms/user/albrechs/genproductions/bin/MadGraph5_aMCatNLO"):
        self.workdir = workdir
        if(not os.path.isdir(self.workdir)):
            os.makedirs(self.workdir)

        self.card_dir = options.directory + ('/' if options.directory[-1] is not '/' else '')

        from glob import glob
        self.processes = [i.split('/')[-1] for i in glob(self.card_dir+'*')]
        self.worker = len(self.processes)

        self.nice = True
        self.commands = [(('nice -n 3 ' if self.nice else '') + './gridpack_generation.sh %s '%self.processes[i]+self.card_dir+self.processes[i]).split(' ') for i in range(self.worker)]

        print('dir:',self.card_dir)
        print('processes:')
        for i in self.processes:
            print(i)
        
        
    def submit_job(self,job_index):
        nice = True
        subprocess.call(self.commands[job_index], stdout=open("/dev/null","w"), stderr=subprocess.STDOUT)
        global n_finished
        with n_finished.get_lock():
            n_finished.value += 1
        return 1

    def start(self):
        global n_finished
        n_finished = Value('i',0)

        print('generating gridpacks for %s:'%self.card_dir+(', '.join(' %s'%i for i in self.processes)))
        print('starting pool with %i workers'%self.worker)
        pool = Pool(processes = self.worker, initializer = init, initargs = (n_finished,))

        result = pool.map_async(submit_job_unpack,[(self,i) for i in range(self.worker)], chunksize = 1)
        
        while not result.ready():
            with n_finished.get_lock():
                done = n_finished.value
            sys.stdout.write("\r(" + str(done)+"/"+str(self.worker)+") done.")
            sys.stdout.flush()
            time.sleep(5)

        print(result.get())
        pool.close()
        pool.join()
        
if(__name__ == "__main__"):
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--directory',required=True, help='number of workers')
    parser.add_argument('--submit',action='store_true', help='submit workers')
    args = parser.parse_args()

    greeting = "== GridpackGeneration =="
    print("="*len(greeting))
    print(greeting)
    print("="*len(greeting))

    
    manager = JobManager(args)
    if(args.submit):
        manager.start()
        

    
    
