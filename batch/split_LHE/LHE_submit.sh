#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/batch/split_LHE/
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/split_LHE/

cd $WORKDIR

rm -rf *

cp $SCRIPTDIR/LHE_PROC.sh $WORKDIR
cp $SCRIPTDIR/LHE_cfg.py $WORKDIR



for ((j=0;j<100;j+=1))
do
    cd $WORKDIR
    mkdir ${j}
    cd ${j}
    qsub -l distro=sld6 -l h_vmem=10G -l h_rt=12:59:59 -cwd -N LHE_$1 ../LHE_PROC.sh ${j}    
    #source ../LHE_PROC.sh ${j}
done


