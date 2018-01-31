#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/scripts/GENSIM/
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/GENSIM/${2}

#module use -a /afs/desy.de/group/cms/modulefiles/; module load cmssw            
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
# if [ -r CMSSW_7_1_19/src ] ; then 
#  echo release CMSSW_7_1_19 already exists
# else
#  scram p CMSSW CMSSW_7_1_19
# fi
cd CMSSW_7_1_19/src
eval `scram runtime -sh`
cd $WORKDIR

cp $SCRIPTDIR/GEN_SIM_PROC_cfg.py  GEN_SIM_$2_$1_cfg.py
sed -i "s|MYINT|$1|g" GEN_SIM_$2_$1_cfg.py
sed -i "s|MYPROC|$2|g" GEN_SIM_$2_$1_cfg.py
cmsRun GEN_SIM_$2_$1_cfg.py

