#!/bin/bash
processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
export SCRIPTDIR=$(pwd)
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/GENSIM/

#resubmit:
index=(20 24 42 49 56 79 80)

cp GEN_SIM_PROC.sh $WORKDIR
cd $WORKDIR

if [ -r CMSSW_7_1_19/src ] ; then 
 echo release CMSSW_7_1_19 already exists
else
 scram p CMSSW CMSSW_7_1_19
fi


for i in {0..0}
do
  echo 'copying config for:'
  echo ${processes[$i]}
  #cp GEN_SIM_PROC.sh GEN_SIM_${processes[$i]}.sh
  #for ((j=0;j<100;j+=1))
  for j in {0..6}
  do
    #qsub -l distro=sld6 -l h_vmem=10G -l h_rt=23:59:59 -cwd -N GS_${processes[$i]}_${j} GEN_SIM_PROC.sh ${j} ${processes[$i]}
    qsub -l distro=sld6 -l h_vmem=10G -l h_rt=47:59:59 -cwd -N GS_${processes[$i]}_${index[$j]} GEN_SIM_PROC.sh ${index[$j]} ${processes[$i]}
  done
done

#cd $SCRIPTDIR