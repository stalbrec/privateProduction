#!/bin/bash
#most of this is from https://github.com/mharrend/privateMCproduction/blob/master/trancheprivateproduction.sh
export PERJOB=625
export NJOBS=50

export NEVENTS=$(($PERJOB * $NJOBS))

export REQUESTNAME="privateMCProduction_aQGCZZhadronic"

#Location relative to CMSSW_BASE DIR/src
export GRIDPACKLOCATION="data/aQGC_ZhadZhadJJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz"

source /cvmfs/cms.cern.ch/cmsset_default.sh 

if [ -r CMSSW_7_1_30/src ] ; then
	 echo "CMSSW release already exists. continuing..."
	 cd CMSSW_7_1_30/src
	eval `scramv1 runtime -sh`	 
else
	echo "Install CMSSW in workdir..."
	# scram project CMSSW_7_1_30
	cmsrel CMSSW_7_1_30
	cd CMSSW_7_1_30/src
	eval `scramv1 runtime -sh`
	echo "Loaded CMSSW_7_1_30."

	echo "adding GeneratorInterface."
	git cms-init --upstream-only
	git cms-addpkg GeneratorInterface/LHEInterface

	sed -i "s|tar -xaf ${path}|tar -xaf \${CMSSW_BASE}/${path}|g" GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh
	
	echo "adding lheproducer-template"
	mkdir -p Configuration/GenProduction/python/ThirteenTeV/aQGC_ZZjjhadronic/
	cp ../../aQGC_ZhadZhadJJ_13TeV-madgraph_cff.py    Configuration/GenProduction/python/ThirteenTeV/aQGC_ZZjjhadronic/aQGC_ZhadZhadJJ_13TeV-madgraph_cff.py
	[ -s Configuration/GenProduction/python/ThirteenTeV/aQGC_ZZjjhadronic/aQGC_ZhadZhadJJ_13TeV-madgraph_cff.py ] || exit $?;

	
	echo "Scram b"
	scram b -j 4
fi	
echo "Load crab environment.."
source /cvmfs/cms.cern.ch/crab3/crab.sh

echo "Copy gridpack for production to workdir, so that crab can transfer it also"
echo "from ${genpro} to $CMSSW_BASE/$GRIDPACKLOCATION"
if [ ! -r data ] ; then
	mkdir data
fi
cp $genpro/aQGC_ZhadZhadJJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz $CMSSW_BASE/src/$GRIDPACKLOCATION

cp ../../crabconfig_draft.py ./crabconfig.py



sed -i "s|MYINT0|${PERJOB}|g" crabconfig.py
sed -i "s|MYINT1|${NJOBS}|g" crabconfig.py
sed -i "s|RQNAME|${REQUESTNAME}|g" crabconfig.py
sed -i "s|GRIDPACKLOC|'${GRIDPACKLOCATION}'|g" crabconfig.py
# sed -i "s|GRIDPACKLOC|BASEDIR+'/${GRIDPACKLOCATION}'|g" crabconfig.py


# echo "Load grid-control configuration.."
# cp ../../production.conf ./gc_production.conf

# sed -i "s|MYINT0|${PERJOB}|g" gc_production.conf
# sed -i "s|MYINT1|${NJOBS}|g" gc_production.conf


# cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/aQGC_ZZjjhadronic/aQGC_ZhadZhadJJ_13TeV-madgraph_cff.py --fileout file:LHE_ZZ.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename LHE_ZZ_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n $NEVENTS || exit $? ; 

cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/aQGC_ZZjjhadronic/aQGC_ZhadZhadJJ_13TeV-madgraph_cff.py --fileout file:LHE_ZZ.root --mc --eventcontent LHE --datatier LHE --conditions MCRUN2_71_V1::All --step LHE --python_filename LHE_ZZ_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n $PERJOB || exit $? ; 

sed -i "s|'GRIDPACKLOC'|'src/${GRIDPACKLOCATION}'|g" LHE_ZZ_cfg.py
# sed -i '1iimport os \nBASEDIR = os.environ["CMSSW_BASE"]' LHE_ZZ_cfg.py
	
# cp ../../LHE_cfg.py ./

# echo "Submit crab jobs.."
#crab submit crabconfig.py

# echo "Submit gc jobs.."
#go.py gc_production.conf

echo "created CMSSW Area and all necessary configurations for crab and grid-control."
