#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/scripts/split_LHE/

processes=(WPWP WPWM WMWM WPZ WMZ ZZ)
gridpacks=(WPhadWPhad WPhadWMhad WMhadWMhad WPhadZhad WMhadZhad ZhadZhad)
#gridpackpath=/nfs/dust/cms/user/albrechs/aQGC_VVjj_hadronic_gridpacks/2016
gridpackpath=/nfs/dust/cms/user/albrechs/production/genproductions/bin/MadGraph5_aMCatNLO/old_gridpacks
resub=(17 32 43 44 45 46 50 6 67 7 87 97 99)
#resub=(14 19 33 40 42 53 55 57 59 77 85 86 91 96 98)
NFiles=100

for i in {5..5}
do
  export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/split_LHE/${processes[$i]}
  cd $WORKDIR
  
  #rm -rf *
  
  cp $SCRIPTDIR/LHE_PROC.sh $WORKDIR
  cp $SCRIPTDIR/LHE_cfg.py $WORKDIR
  echo "setting up working directories for ${processes[$i]}"
  for ((j=0;j<$NFiles;j+=1))
  # # for ((j=0;j<${#resub[@]};j+=1))
  do
		cd $WORKDIR
		echo -ne "progress: (${j}/${NFiles})\r"
		if [ -d ${j} ]; then
			rm -rf ${j}
			mkdir ${j}
		else
			mkdir ${j}
		fi

		if [ -f ${processes[$i]}_LHE_${j}.root ]; then
			rm ${processes[$i]}_LHE_${j}.root
		fi
		
		cd $WORKDIR/${j}
		cp ${gridpackpath}/aQGC_${gridpacks[$i]}JJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz ./
    # cp /nfs/dust/cms/user/albrechs/production/genproductions/bin/MadGraph5_aMCatNLO/aQGC_${gridpacks[$i]}JJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz ./
  #qsub -V  -l distro=sld6 -l h_vmem=7G -l h_rt=12:59:59 -cwd -N LHE${processes[$i]}_${j} ../LHE_PROC.sh ${j} ${processes[$i]} ${gridpacks[$i]}
		# rm -rf ${resub[$j]}
    # mkdir ${resub[$j]}
    # cd $WORKDIR/${resub[$j]}
    # rm ${processes[$i]}_LHE_${resub[$j]}.root
    # cp /nfs/dust/cms/user/albrechs/production/genproductions/bin/MadGraph5_aMCatNLO/aQGC_${gridpacks[$i]}JJ_EWK_LO_NPle1_slc6_amd64_gcc481_CMSSW_7_1_30_tarball.tar.xz ./
    # qsub -l distro=sld6 -l h_vmem=7G -l h_rt=12:59:59 -cwd -N LH_${processes[$i]}_${resub[$j]} ../LHE_PROC.sh ${resub[$j]} ${processes[$i]} ${gridpacks[$i]}
    
    #source ../LHE_PROC.sh ${j} ${processes[$i]}
  done
	condor_submit $SCRIPTDIR/setup.submit -batch-name "LHE_${processes[$i]}" -a "channel=${processes[$i]}" -a "gridpack=${gridpacks[i]}" -a "queue ${NFiles}"
done

cd $SCRIPTDIR
