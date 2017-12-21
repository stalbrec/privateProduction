#!/bin/bash
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc530
if [ -r CMSSW_8_0_21/src ] ; then 
 echo release CMSSW_8_0_21 already exists
else
scram p CMSSW CMSSW_8_0_21
fi
cd CMSSW_8_0_21/src
eval `scram runtime -sh`


scram b
cd ../../
cmsDriver.py step1 --filein "file:/nfs/dust/cms/user/albrechs/production/ntuples/DIGIRECO/DIGI_RECO_MYPROC_MYINT.root" --fileout file:MINIAOD_MYPROC_MYINT.root --mc --eventcontent MINIAODSIM --runUnscheduled --datatier MINIAODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step PAT --nThreads 4 --era Run2_2016 --python_filename MINIAOD_MYPROC_MYINT_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 500 || exit $? ; 

