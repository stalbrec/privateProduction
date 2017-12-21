import FWCore.ParameterSet.Config as cms

# link to cards:
# https://github.com/cms-sw/genproductions/tree/91ab3ea30e3c2280e4c31fdd7072a47eb2e5bdaa/bin/MadGraph5_aMCatNLO/cards/production/13TeV/exo_diboson/Spin-2/BulkGraviton_WW_WlepWhad/BulkGraviton_WW_WlepWhad_narrow_M2000


externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('/nfs/dust/cms/user/albrechs/production/genproductions/bin/MadGraph5_aMCatNLO/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz'),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)
