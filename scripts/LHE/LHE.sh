#!/bin/bash
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
if [ -r CMSSW_7_1_30/src ] ; then
  echo CMSSW release already exists
else
scram p CMSSW CMSSW_7_1_30
fi
cd CMSSW_7_1_30/src
eval `scram runtime -sh`
mkdir -p Configuration/GenProduction/python/ThirteenTeV/
cp ../../aQGC_WPhadWPhadJJ_EWK_LO_NPle1_13TeV-madgraph_cff.py Configuration/GenProduction/python/ThirteenTeV/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_13TeV-madgraph_cff.py
[ -s Configuration/GenProduction/python/ThirteenTeV/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_13TeV-madgraph_cff.py ] || exit $?;

scram b
cd ../../

cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_13TeV-madgraph_cff.py --fileout file:WPWP_LHE.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename LHE_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 50000 || exit $? ;