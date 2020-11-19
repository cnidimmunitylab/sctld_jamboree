#!/bin/bash
#./bash/fastqc.sh
#purpose: quality checking of raw RNAseq reads using FASTQC on Pegasus compute node
#To start this job from the sctld_jamboree/rnaseq directory, use:
#bsub -P transcriptomics < ./bash/fastqc.sh

#BSUB -J fastqc
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o fastqc%J.out
#BSUB -e fastqc%J.err
#BSUB -n 8
#BSUB -u mconnelly@rsmas.miami.edu
#BSUB -N

#specify variable containing sequence file prefixes and directory paths
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/sctld_jamboree/rnaseq"
samples="K1 K2 K6 K7 K8 K12 K13"

module load java/1.8.0_60
module load fastqc/
fastqc ${prodir}/data/reads/[K][123456]*.txt.gz \
--outdir ${prodir}/outputs/fastqcs/
