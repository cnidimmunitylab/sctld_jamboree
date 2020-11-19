#!/bin/bash
# following this link to generate transcript-to-gene annotation for O. faveolata
# NCBI Assembly GCF_002042975.1
assembly="GCF_002042975.1_ofav_dov_v1"
#gtf file
cat ~/Downloads/GCF_002042975.1_ofav_dov_v1_genomic.gff | grep -v "#" | cut -f3 | sort | uniq -c
# create tx2gene
cat ~/Downloads/GCF_002042975.1_ofav_dov_v1_genomic.gff | grep -v "#" | awk '$3=="mRNA"' | cut -f9 | tr -s ";" " " | awk '{print$1"\t"$2}' | sort | uniq | sed 's/ID=//g' | sed 's/Parent=gene-//g' > tx2gene_ofav.tsv 
