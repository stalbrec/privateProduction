#!/bin/bash
processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
export SCRIPTDIR=$(pwd)

for i in {0..0}
do
  export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/MINIAOD/${processes[$i]}
  cd $WORKDIR

  # resubmit:
  # index=(20 24 42 49 56 79 80)

  cp $SCRIPTDIR/MINIAOD_PROC.sh $WORKDIR

  source /cvmfs/cms.cern.ch/cmsset_default.sh
  export SCRAM_ARCH=slc6_amd64_gcc530
  if [ -r CMSSW_8_0_21/src ] ; then 
    echo release CMSSW_8_0_21 already exists
  else
    scram p CMSSW CMSSW_8_0_21
  fi
  rm *_${j}.o* *_${j}.e*

  for ((j=0;j<100;j+=1))
  #for j in {0..6}
  do
    rm *${j}.root

    qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd -N MA_${processes[$i]}_${j} MINIAOD_PROC.sh ${j} ${processes[$i]}
    #source MINIAOD_PROC.sh ${j} ${processes[$i]}
    #qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd -N MA_${index[$j]} MINIAOD_PROC.sh ${index[$j]} ${processes[$i]}
  done
done
