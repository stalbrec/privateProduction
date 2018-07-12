#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/scripts/split_LHE/
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/split_LHE/${2}

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
if [ -r CMSSW_7_1_30/src ] ; then
 echo CMSSW release already exists
else
 scram p CMSSW CMSSW_7_1_30
fi
cd CMSSW_7_1_30/src
eval `scram runtime -sh`
cd $WORKDIR/$1

cp ../LHE_cfg.py LHE_cfg_$2_$1.py

sed -i "s|MYINT|$1|g" LHE_cfg_$2_$1.py
sed -i "s|MYPROCLONG|$3|g" LHE_cfg_$2_$1.py
sed -i "s|MYPROC|$2|g" LHE_cfg_$2_$1.py

cmsRun LHE_cfg_$2_$1.py