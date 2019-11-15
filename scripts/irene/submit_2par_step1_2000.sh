#!/bin/sh

for ((II=1;II<$1;II+=1))
do
    for((X=0;X<$2;X+=1))
    do
	qsub -l distro=sld6 -l h_vmem=10G -l h_rt=11:59:59 DIGI_RECO_step1_2000.sh ${II} ${X}
    done
done

