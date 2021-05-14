#!/bin/sh

# SLURM #
#SBATCH --output 999.logs/STAR_map_%A_%a.log
#SBATCH --mem=10GB
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=8
#SBATCH --array=0-94:2

# MODULES #
ml star/2.7.1a-foss-2018b
ml samtools/1.9-foss-2018b

# DATA #
i=$SLURM_ARRAY_TASK_ID
MAINdir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/009.TE_expression_Laura
FASTQdir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/000.general_data/001.data/003.fastq_trimmed
INDEX=${MAINdir}/001.data/001.TE_STAR_index

#FASTQlst=${FASTQdir}fastq_trimmed_list.txt
FASTQfiles=(${FASTQdir}/*.fq)
FASTQ1=${FASTQfiles[$i]}
FASTQ2=${FASTQfiles[$i + 1]}

FASTQbase=$(basename -s .end1_val_1.fq $FASTQ1)

cores=8
STAR_out=${MAINdir}/001.data/002.TE_STAR_BAM/${FASTQbase}/

mkdir -p $STAR_out

# RUN #
# settings based on https://doi.org/10.1186/s13100-019-0192-1
STAR \
--runMode alignReads \
--runThreadN $cores \
--alignIntronMax 1 \
--alignMatesGapMax 350 \
--outFilterMultimapNmax 1 \
--outFilterMismatchNmax 3 \
--alignEndsType EndToEnd \
--genomeDir $INDEX \
--readFilesIn $FASTQ1 $FASTQ2 \
--outFileNamePrefix $STAR_out \
--outSAMattributes NH HI AS nM NM MD jM jI XS 



