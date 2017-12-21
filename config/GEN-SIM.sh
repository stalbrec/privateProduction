#!/bin/bash
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
if [ -r CMSSW_7_1_19/src ] ; then 
 echo release CMSSW_7_1_19 already exists
else
scram p CMSSW CMSSW_7_1_19
fi
cd CMSSW_7_1_19/src
eval `scram runtime -sh`
curl  -s https://raw.githubusercontent.com/cms-sw/genproductions/d91dc7801f60176f6b02d2ffd1d0b00307392e4f/python/ThirteenTeV/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py --retry 2 --create-dirs -o  Configuration/GenProduction/python/ThirteenTeV/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py 
[ -s Configuration/GenProduction/python/ThirteenTeV/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py ] || exit $?;

#ACHTUNG: Hier wird noch nicht das ueberspringen von Events eingefuehrt! Muss noch manuell hinzugefuegt werden.

scram b
cd ../../
cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py --filein "file:/nfs/dust/cms/user/albrechs/production/ntuples/LHE/MYPROC_LHE.root" --fileout file:GEN_SIM_MYPROC_MYINT.root --mc --eventcontent RAWSIM --customise SLHCUpgradeSimulations/Configuration/postLS1Customs.customisePostLS1,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --conditions MCRUN2_71_V1::All --beamspot Realistic50ns13TeVCollision --step GEN,SIM --magField 38T_PostLS1 --python_filename GEN_SIM_PROC_cfg.py --no_exec -n 500 || exit $? ; 

#cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/Hadronizer_TuneCUETP8M1_13TeV_generic_LHE_pythia8_cff.py --filein "dbs:/VBF_BulkGravToWW_narrow_M-2000_13TeV-madgraph/RunIIWinter15wmLHE-MCRUN2_71_V1-v2/LHE" --fileout file:EXO-RunIISummer15GS-01091.root --mc --eventcontent RAWSIM --customise SLHCUpgradeSimulations/Configuration/postLS1Customs.customisePostLS1,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --conditions MCRUN2_71_V1::All --beamspot Realistic50ns13TeVCollision --step GEN,SIM --magField 38T_PostLS1 --python_filename EXO-RunIISummer15GS-01091_1_cfg.py --no_exec -n 19 || exit $? ; 
