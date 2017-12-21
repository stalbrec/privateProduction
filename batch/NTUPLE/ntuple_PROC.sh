#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/batch/NTUPLE
export WORKDIR=/nfs/dust/cms/user/albrechs/CMSSW_8_0_24_patch1/src/UHH2/core/python/NTUPLE_WORK

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc_amd64_gcc530

# if [ -r CMSSW_8_0_21/src ] ; then
#   echo release CMSSW_8_0_21 already exists
# else
#   scram p CMSSW CMSSW_8_0_21
# fi
eval `scram runtime -sh`

cp aQGCWPWP_ntuplewriter.py aQGCWPWP_ntuplewriter_$1.py 
sed -i "s|MYINT|$1|g" aQGCWPWP_ntuplewriter_$1.py 
sed -i "s|MYPROC|$2|g" aQGCWPWP_ntuplewriter_$1.py 
cmsRun aQGCWPWP_ntuplewriter_$1.py 
