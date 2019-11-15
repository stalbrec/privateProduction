#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/batch/LHE/
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/LHE/

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
if [ -r CMSSW_7_1_30/src ] ; then
 echo CMSSW release already exists
else
 scram p CMSSW CMSSW_7_1_30
fi
cd CMSSW_7_1_30/src
eval `scram runtime -sh`
cd $WORKDIR
cmsRun LHE_cfg.py