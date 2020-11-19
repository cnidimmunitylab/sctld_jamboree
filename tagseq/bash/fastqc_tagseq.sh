#!/bin/bash
#./bash/fastqc.sh
#purpose: quality checking of raw RNAseq reads using FASTQC on Pegasus compute node
#To start this job from the sctld_jamboree/tagseq directory, use:
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
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/sctld_jamboree/tagseq"
# making a list of sample names
samples=`ls /scratch/projects/transcriptomics/ben_young/SCTLD/raw_reads | cut -f 1 -d '.'`
ksamples=`echo $samples | cut -f 3 -d '_'`

module load java/1.8.0_60
module load fastqc/0.10.1
bzip2 -d ${prodir}/data/raw_reads/*.fastq.bz2
fastqc ${prodir}/data/raw_reads/*.fastq \
--outdir ${prodir}/outputs/logfiles/fastqcs/

echo "fastqc complete on $ksamples"
