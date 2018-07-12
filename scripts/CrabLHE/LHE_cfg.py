# Auto generated configuration file
# using: 
# Revision: 1.19 
# Source: /local/reps/CMSSW/CMSSW/Configuration/Applications/python/ConfigBuilder.py,v 
# with command line options: Configuration/GenProduction/python/ThirteenTeV/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_13TeV-madgraph_cff.py --fileout file:WPWP_LHE.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename LHE_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n 5000
import FWCore.ParameterSet.Config as cms

process = cms.Process('LHE')

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('SimGeneral.MixingModule.mixNoPU_cfi')
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load('Configuration.StandardSequences.MagneticField_38T_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(10)
)

# Input source
process.source = cms.Source("EmptySource")

process.options = cms.untracked.PSet(

)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    version = cms.untracked.string('$Revision: 1.19 $'),
    annotation = cms.untracked.string('Configuration/GenProduction/python/ThirteenTeV/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_13TeV-madgraph_cff.py nevts:10'),
    name = cms.untracked.string('Applications')
)

# Output definition

process.LHEoutput = cms.OutputModule("PoolOutputModule",
    splitLevel = cms.untracked.int32(0),
    eventAutoFlushCompressedSize = cms.untracked.int32(5242880),
    outputCommands = process.LHEEventContent.outputCommands,
    fileName = cms.untracked.string('ZZ_LHE.root'),
    dataset = cms.untracked.PSet(
        filterName = cms.untracked.string(''),
        dataTier = cms.untracked.string('LHE')
    )
)


# Additional output definition

# Other statements
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, 'MCRUN2_71_V1::All', '')

process.externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    nEvents = cms.untracked.uint32(10),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh'),
    numberOfParameters = cms.uint32(1),
    # args = cms.vstring('aQGC_ZhadZhadJJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz')
    args = cms.vstring('/nfs/dust/cms/user/albrechs/production/genproductions/bin/MadGraph5_aMCatNLO/aQGC_WPhadWPhadJJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz')
)

# process.RandomNumberGeneratorService.externalLHEProducer.initialSeed=500000
# process.RandomNumberGeneratorService = cms.Service("RandomNumberGeneratorService",
#     externalLHEProducer = cms.PSet(
#         initialSeed = cms.untracked.uint32(500000),
#         engineName = cms.untracked.string('HepJamesRandom')
#     )
# )


# Path and EndPath definitions
process.lhe_step = cms.Path(process.externalLHEProducer)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.LHEoutput_step = cms.EndPath(process.LHEoutput)

# Schedule definition
process.schedule = cms.Schedule(process.lhe_step,process.endjob_step,process.LHEoutput_step)

# customisation of the process.

# Automatic addition of the customisation function from Configuration.DataProcessing.Utils
from Configuration.DataProcessing.Utils import addMonitoring 

#call to customisation function addMonitoring imported from Configuration.DataProcessing.Utils
process = addMonitoring(process)

# End of customisation functions

def customise_for_gc(process):
	import FWCore.ParameterSet.Config as cms
	from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper

	try:
		maxevents = int(__MAX_EVENTS__)
		process.maxEvents = cms.untracked.PSet(
			input = cms.untracked.int32(max(-1, maxevents))
		)
	except Exception:
		pass

	# Dataset related setup
	try:
		primaryFiles = [__FILE_NAMES__]
		process.source = cms.Source('PoolSource',
			skipEvents = cms.untracked.uint32(__SKIP_EVENTS__),
			fileNames = cms.untracked.vstring(primaryFiles)
		)
		try:
			secondaryFiles = [__FILE_NAMES2__]
			process.source.secondaryFileNames = cms.untracked.vstring(secondaryFiles)
		except Exception:
			pass
		try:
			lumirange = [__LUMI_RANGE__]
			if len(lumirange) > 0:
				process.source.lumisToProcess = cms.untracked.VLuminosityBlockRange(lumirange)
				process.maxEvents = cms.untracked.PSet(input = cms.untracked.int32(-1))
		except Exception:
			pass
	except Exception:
		pass

	if hasattr(process, 'RandomNumberGeneratorService'):
		randSvc = RandomNumberServiceHelper(process.RandomNumberGeneratorService)
		randSvc.populate()

	process.AdaptorConfig = cms.Service('AdaptorConfig',
		enable = cms.untracked.bool(True),
		stats = cms.untracked.bool(True),
	)

	# Generator related setup
	try:
		if hasattr(process, 'generator') and process.source.type_() != 'PoolSource':
			process.source.firstLuminosityBlock = cms.untracked.uint32(1 + __GC_JOB_ID__)
			print('Generator random seed: %s' % process.RandomNumberGeneratorService.generator.initialSeed)
	except Exception:
		pass

	# Print GlobalTag for DBS3 registration - output is taken from edmConfigHash
	try:
		print('globaltag:%s' % process.GlobalTag.globaltag.value())
	except Exception:
		pass
	return (process)

process = customise_for_gc(process)

# Source: github.com/grid-control
