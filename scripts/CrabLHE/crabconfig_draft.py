from WMCore.Configuration import Configuration
from CRABClient.UserUtilities import config, getUsernameFromSiteDB
import os
BASEDIR = os.environ["CMSSW_BASE"]
config = Configuration()

config.section_("General")
config.General.requestName = "RQNAME"
config.General.workArea = 'crab_privateMCProduction_aQGCZZhadronic'
config.General.transferLogs = True
config.General.transferOutputs = True

config.section_("JobType")
config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'LHE_ZZ_cfg.py'
config.JobType.inputFiles = ['GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh', GRIDPACKLOC]
config.JobType.disableAutomaticOutputCollection = False

config.section_("Data")
config.Data.outputPrimaryDataset = 'privateMCProductionLHE'
config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = MYINT0
NJOBS = MYINT1  # This is not a configuration parameter, but an auxiliary variable that we use in the next line.
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS
config.Data.publication = True
config.Data.outputDatasetTag = 'privateMC_LHE_aQGCZZhadronic'
config.Data.outLFNDirBase = '/store/user/%s/Private_MCRun2_71_v1_aQGCZZhadronic/LHE/' % (getUsernameFromSiteDB())

config.section_("Site")
config.Site.storageSite = 'T2_DE_DESY'
config.Site.whitelist = ['T2_*']

config.section_("User")
## only german users
#config.User.voGroup = "dcms"





