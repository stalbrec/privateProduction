#!/bin/bash
export SCRIPTDIR=/nfs/dust/cms/user/albrechs/production/batch/LHE
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/LHE/

cd $WORKDIR

rm -rf *

cp $SCRIPTDIR/LHE_PROC.sh $WORKDIR
cp $SCRIPTDIR/LHE_cfg.py $WORKDIR


qsub -l distro=sld6 -l h_vmem=32G -l h_rt=167:59:59 -cwd -N LHE_WPWP LHE_PROC.sh 

