#!/bin/bash
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
if [ -r CMSSW_7_1_15_patch1/src ] ; then 
 echo release CMSSW_7_1_15_patch1 already exists
else
scram p CMSSW CMSSW_7_1_15_patch1
fi
cd CMSSW_7_1_15_patch1/src
eval `scram runtime -sh`
curl  -s https://raw.githubusercontent.com/cms-sw/genproductions/d91dc7801f60176f6b02d2ffd1d0b00307392e4f/python/ThirteenTeV/BulkGraviton_WW_WlepWhad_narrow_M2000_13TeV-madgraph_cff.py --retry 2 --create-dirs -o  Configuration/GenProduction/python/ThirteenTeV/BulkGraviton_WW_WlepWhad_narrow_M2000_13TeV-madgraph_cff.py 
[ -s Configuration/GenProduction/python/ThirteenTeV/BulkGraviton_WW_WlepWhad_narrow_M2000_13TeV-madgraph_cff.py ] || exit $?;

export X509_USER_PROXY=$HOME/private/personal/voms_proxy.cert

scram b
cd ../../
cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/BulkGraviton_WW_WlepWhad_narrow_M2000_13TeV-madgraph_cff.py --fileout file:EXO-RunIIWinter15wmLHE-00112.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename EXO-RunIIWinter15wmLHE-00112_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 10000 || exit $? ; 
