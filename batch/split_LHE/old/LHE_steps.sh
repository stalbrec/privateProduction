#!/bin/bash
processes=(WPhadWPhad WMhadWMhad WPhadWMhad WPhadZhad WMhadZhad ZhadZhad)

export SCRIPTDIR=$(pwd)
export WORKDIR=/nfs/dust/cms/user/albrechs/production/ntuples/LHE/

cp LHE_PROC.sh $WORKDIR
cd $WORKDIR

for i in {0..0}
do
    for ((j=0;j<$1;j+=1))
    do
	source LHE_PROC.sh ${j} ${processes[$i]}
    done
done


