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
cmsDriver.py step1 --filein "file:/nfs/dust/cms/user/albrechs/production/ntuples/GENSIM/GEN_SIM_MYPROC_MYINT.root" --fileout file:DIGI_RECO_MYPROC_MYINT_step1.root  --pileup_input "file:/nfs/dust/cms/user/albrechs/production/config/pileupNew.root" --mc --eventcontent RAWSIM --datatier GEN-SIM-RAW --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,HLT:@frozen2016 --nThreads 4 --datamix PreMix --era Run2_2016 --python_filename DIGI_RECO_MYPROC_MYINT_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 500 || exit $? ; 

cmsDriver.py step2 --filein file:DIGI_RECO_MYPROC_MYINT_step1.root --fileout file:DIGI_RECO_MYPROC_MYINT.root --mc --eventcontent AODSIM --runUnscheduled --datatier AODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step RAW2DIGI,RECO,EI --nThreads 4 --era Run2_2016 --python_filename DIGI_RECO_MYPROC_MYINT_2_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 500 || exit $? ; 


#dbs:/Neutrino_E-10_gun/RunIISpring15PrePremix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v2-v2/GEN-SIM-DIGI-RAW
#--eventcontent RAWSIM --pileup 2016_25ns_Moriond17MC_PoissonOOTPU --datatier GEN-SIM-RAW --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v2 --customise_commands "process.mix.input.nbPileupEvents.probFunctionVariable = cms.vint32(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70) \n process.mix.input.nbPileupEvents.probValue = cms.vdouble(0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085,0.014085)" --step DIGI,L1,DIGI2RAW,HLT:@frozen2016 --era Run2_2016 --python_filename JME-RunIISummer16DR80-00004_1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n -1 || exit $? ;