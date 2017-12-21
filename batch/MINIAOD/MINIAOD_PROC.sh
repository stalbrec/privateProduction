#!/bin/bash

export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/batch/MINIAOD/
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/MINIAOD/

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
# if [ -r CMSSW_8_0_21/src ] ; then 
#  echo release CMSSW_8_0_21 already exists
# else
# scram p CMSSW CMSSW_8_0_21
# fi
cd CMSSW_8_0_21/src
eval `scram runtime -sh`
cd $WORKDIR

cp $SCRIPTDIR/MINIAOD_MYPROC_cfg.py MINIAOD_$2_$1_cfg.py
sed -i "s|MYINT|$1|g" MINIAOD_$2_$1_cfg.py
sed -i "s|MYPROC|$2|g" MINIAOD_$2_$1_cfg.py
cmsRun MINIAOD_$2_$1_cfg.py