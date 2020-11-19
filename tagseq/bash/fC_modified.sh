#!/bin/bash
#./bash/featureCounts_modified.sh
#purpose: quantify STAR-aligned BAM files at the gene level using featureCounts
#To start this job from the sctld_jamboree/tagseq directory, use:
#bsub -P transcriptomics < ./bash/featureCounts_modified.sh

#BSUB -J fC_modified
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o fC_modified%J.out
#BSUB -e fC_modified%J.err
#BSUB -n 8
#BSUB -u mconnelly@rsmas.miami.edu
#BSUB -N

#specify variable containing sequence file prefixes and directory paths
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/sctld_jamboree/tagseq"
# making a list of sample names
samples=`ls /scratch/projects/transcriptomics/ben_young/SCTLD/raw_reads | cut -f 1 -d '.'`

module load samtools
module load subread

for samp in $samples ; do
#samtools index ${prodir}/outputs/alignments/${samp}_Aligned.sortedByCoord.out.bam
samtools view -q 255 -Sub ${prodir}/outputs/alignments/${samp}_Aligned.sortedByCoord.out.bam \
-o ${prodir}/outputs/alignments/${samp}_Aligned.sortedByCoord.out.uniq.bam
done

featureCounts -T 5 -t gene -s 1 \
-a ${prodir}/data/refs/GCF_002042975.1_ofav_dov_v1_genomic.gtf \
-o ${prodir}/outputs/ofav_counts \
${prodir}/outputs/alignments/*uniq.bam
