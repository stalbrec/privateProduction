#!/bin/bash
processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
export SCRIPTDIR=$(pwd)
export WORKDIR=/nfs/dust/cms/user/albrechs/CMSSW_8_0_24_patch1/src/UHH2/core/python/NTUPLE_WORK

#resubmit:
index=(20 24 42 49 56 79 80)

cp ntuple_PROC.sh $WORKDIR
cp /nfs/dust/cms/user/albrechs/CMSSW_8_0_24_patch1/src/UHH2/core/python/aQGCWPWP_ntuplewriter.py $WORKDIR

cd $WORKDIR

for i in {0..0}
do
echo ${processes[$i]}
  #for ((j=0;j<100;j+=1))
  for j in {0..6}
  do
      #qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd  -N NT_${j} ntuple_PROC.sh ${j} ${processes[$i]}
      qsub -l distro=sld6 -l h_vmem=10G -l h_rt=14:59:59 -cwd  -N NT_${index[$j]} ntuple_PROC.sh ${index[$j]} ${processes[$i]}
  done
done

