#!/bin/bash
processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
export SCRIPTDIR=$(pwd)
NFiles=100

for i in {5..5}
do
  export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/GENSIM/${processes[$i]}
  cd $WORKDIR

  #resubmit:
  #index=(20 24 42 49 56 79 80)

  cp $SCRIPTDIR/GEN_SIM_PROC.sh $WORKDIR

  if [ -r CMSSW_7_1_19/src ] ; then 
    echo release CMSSW_7_1_19 already exists
  else
    scram p CMSSW CMSSW_7_1_19
  fi

  rm *.o* *.e*
  for ((j=0;j<${NFiles};j+=1))
  #for j in {0..6}
  do
		if[ -f GEN_SIM_${processes[$i]}_${j}.root];then			
			rm  GEN_SIM_${processes[$i]}_${j}.root
		fi

    # qsub -l distro=sld6 -l h_vmem=10G -l h_rt=23:59:59 -cwd -N GS_${processes[$i]}_${j} GEN_SIM_PROC.sh ${j} ${processes[$i]}
    #source GEN_SIM_PROC.sh ${j} ${processes[$i]} 
    #qsub -l distro=sld6 -l h_vmem=10G -l h_rt=47:59:59 -cwd -N GS_${processes[$i]}_${index[$j]} GEN_SIM_PROC.sh ${index[$j]} ${processes[$i]}
  done
	condor_submit $SCRIPTDIR/setup.submit -batch-name "GENSIM_${processes[$i]}" -a "channel=${processes[$i]}" -a "queue ${NFiles}"

done
