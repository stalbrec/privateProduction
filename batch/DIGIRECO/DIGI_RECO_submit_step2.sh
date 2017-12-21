#!/bin/bash
processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
export SCRIPTDIR=$(pwd)
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/DIGIRECO/

#resubmit: ${index[$j]}
index=(20 24 42 49 56 79 80)

cp DIGI_RECO_PROC_step2.sh $WORKDIR
cd $WORKDIR

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc530
if [ -r CMSSW_8_0_21/src ] ; then
  echo release CMSSW_8_0_21 already exists
else
  scram p CMSSW CMSSW_8_0_21
fi

for i in {0..0}
do
echo ${processes[$i]}
  #for ((j=0;j<100;j+=1))
  for j in {0..6}
  do
      #qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd  -N DR_2_${j} DIGI_RECO_PROC_step2.sh ${j} ${processes[$i]}
      qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd  -N DR_2_${index[$j]} DIGI_RECO_PROC_step2.sh ${index[$j]} ${processes[$i]}
  done
done

