#!/bin/bash
#$ -S /bin/sh
#$ -cwd
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc530
cd /nfs/dust/cms/user/zoiirene/DiBoson/GravitonToWW/FixingPU
cd CMSSW_8_0_21/src
eval `scram runtime -sh`

export MYNUM=$1
export MYINT=$2
cd /nfs/dust/cms/user/zoiirene/DiBoson/GravitonToWW/FixingPU
#    root -l -q -b 'runSTU.C("TwoHDM_ScanND_withHBR.xml")'
cp EXO-RunIISummer16DR80Premix-08160_1_cfg_2000_2par.py EXO-RunIISummer16DR80Premix-08160_1_cfg_2000_$1_$2.py 
sed -i "s|MYNUM|$1|g" EXO-RunIISummer16DR80Premix-08160_1_cfg_2000_$1_$2.py
sed -i "s|MYINT|$2|g" EXO-RunIISummer16DR80Premix-08160_1_cfg_2000_$1_$2.py
cmsRun EXO-RunIISummer16DR80Premix-08160_1_cfg_2000_$1_$2.py