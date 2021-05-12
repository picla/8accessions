#!/bin/sh

# SLURM #
#SBATCH --output 999.logs/STAR_map_%A_%a.log
#SBATCH --mem=10GB
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8
#SBATCH --array=1-95:2

# MODULES #
ml star/2.7.1a-foss-2018b
ml samtools/1.9-foss-2018b 

# DATA #
i=$PBS_ARRAY_INDEX
MAINdir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/009.TE_expression_Laura
FASTQdir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/000.general_data/001.data/003.fastq_trimmed
INDEX=${MAINdir}/001.data/001.TE_STAR_index

#FASTQlst=${FASTQdir}fastq_trimmed_list.txt
FASTQfiles=(${FASTQdir}/*.fq)
FASTQ1=${FASTQfiles[$i]}
FASTQ2=${raw_fq1/end1_val1/end2_val2}

FASTQbase=$(basename -s .end1.fastq $FASTQ1)

cores=8
STAR_out=${MAINdir}/001.data/002.TE_STAR_BAM/${FASTQbase}/

mkdir -p $STAR_out

# RUN #
STAR \
--runMode alignReads \
--twopassMode Basic \
--runThreadN $cores \
--alignIntronMax 4000 \
--alignMatesGapMax 4000 \
--outFilterIntronMotifs RemoveNoncanonical \
--outSAMattributes NH HI AS nM NM MD jM jI XS \
--outSAMtype BAM SortedByCoordinate \
--quantMode TranscriptomeSAM \
--genomeDir $INDEX \
--readFilesIn $FASTQ1 $FASTQ2 \
--outFileNamePrefix $STAR_out

# rezip fastq files #
echo 'rezipping'
pigz $FASTQ1
pigz $FASTQ2

