#!/bin/sh

# SLURM # 
#SBATCH --output 999.logs/bamToFastq_%A_%a.log
#SBATCH --mem=10GB
#SBATCH --time=01:00:00
#SBATCH --array=1-60

# WARNING: script suffers from random craches due to stale file handling in internal files of bedtools and/or samtools.
# check log files after running and rerun failed processes

# MODULES #
ml bedtools/2.27.1-foss-2018b
ml samtools/1.10-foss-2018b

# DATA #
i=$SLURM_ARRAY_TASK_ID
DATAdir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/000.general_data/001.data
BAMlst=${DATAdir}/001.bamfiles/bam_list.txt
FASTQdir=${DATAdir}/002.fastqfiles

mkdir -p $FASTQdir

BAM=$(sed "${i}q;d" $BAMlst)
BAMbase=$(basename -s .bam $BAM)

BAMsort=${DATAdir}/001.bamfiles/${BAMbase}.qsort.bam
FASTQ1=${FASTQdir}/${BAMbase}.end1.fastq
FASTQ2=${FASTQdir}/${BAMbase}.end2.fastq

# sort bam file in order to make 2 fastq files -> paired-end data
samtools sort -n $BAM -o $BAMsort

echo 'bamfile sorted'

# split sorted BAM file into two fastq files (paired-end data)
bedtools bamtofastq -i $BAMsort -fq $FASTQ1 -fq2 $FASTQ2

echo 'bamtofastq finished'


