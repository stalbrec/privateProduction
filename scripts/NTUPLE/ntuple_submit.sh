#!/bin/bash
processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
export SCRIPTDIR=$(pwd)

for i in {0..5}
do
  export WORKDIR=/nfs/dust/cms/user/albrechs/CMSSW_8_0_24_patch1/src/UHH2/core/python/NTUPLE_WORK/${processes[$i]}
  cd $WORKDIR

  # resubmit:
  # index=(20 24 42 49 56 79 80)
  rm *

  cp $SCRIPTDIR/ntuple_PROC.sh $WORKDIR
  cp /nfs/dust/cms/user/albrechs/CMSSW_8_0_24_patch1/src/UHH2/core/python/aQGCMYPROC_ntuplewriter.py $WORKDIR


  echo ${processes[$i]}
  for ((j=0;j<100;j+=1))
  #for j in {0..6}
  do
    qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd  -N NT_${j} ntuple_PROC.sh ${j} ${processes[$i]}
    #source ntuple_PROC.sh ${j} ${processes[$i]}
    #qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd  -N NT_${index[$j]} ntuple_PROC.sh ${index[$j]} ${processes[$i]}
  done
done

