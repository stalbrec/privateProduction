import FWCore.ParameterSet.Config as cms

process = cms.Process("LHE")

process.externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh'),
    outputFile = cms.string('MYPROC_MYINT.lhe'),
    numberOfParameters = cms.uint32(1),
    args = cms.vstring('/nfs/dust/cms/user/albrechs/production/genproductions/bin/MadGraph5_aMCatNLO/aQGC_MYPROCJJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz'),
    nEvents = cms.untracked.uint32(500)
)
