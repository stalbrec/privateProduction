#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/batch/DIGIRECO/
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/DIGIRECO/

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc_amd64_gcc530
# if [ -r CMSSW_8_0_21/src ] ; then
#   echo release CMSSW_8_0_21 already exists
# else
#   scram p CMSSW CMSSW_8_0_21
# fi
cd CMSSW_8_0_21/src
eval `scram runtime -sh`
cd $WORKDIR

cp $SCRIPTDIR/DIGI_RECO_MYPROC_MYINT_2_cfg.py DIGI_RECO_$2_$1_2_cfg.py 
sed -i "s|MYINT|$1|g" DIGI_RECO_$2_$1_2_cfg.py 
sed -i "s|MYPROC|$2|g" DIGI_RECO_$2_$1_2_cfg.py 
cmsRun DIGI_RECO_$2_$1_2_cfg.py 
