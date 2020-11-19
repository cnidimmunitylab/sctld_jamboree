#!/bin/bash
for i in *.bam 
do 
samtools view -q 255 -Sub ${i} > ${i}_unique.bam
done
