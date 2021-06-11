#!/usr/bin/env bash

# SLURM
#SBATCH --output=999.logs/pseudotranscriptome_%A_%a.log
#SBATCH --time=06:00:00
#SBATCH --mem=10GB
#SBATCH --array=0-6


# MODULES #
ml python/3.8.6-gcccore-10.2.0

PSEUDOGENIZE=002.scripts/002.pseudogenome.py

# DATA #
i=$SLURM_ARRAY_TASK_ID
WORK=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/
FASTA=${WORK}001.data/TAIR10_chr_all.fas

VCFfiles=(${WORK}001.data/1001genomes_snp-short-indel_only_ACGTN_*.vcf)
VCF=${VCFfiles[$i]}

OUT=${VCF/.vcf/_pseudoTAIR10.fasta}

# MAKE PSEUDO GENOMES #
python $PSEUDOGENIZE -O $OUT $FASTA $VCF

# add Chr as prefix for chromosome names
awk '/>[0-9]/{gsub(/>/,">Chr")}{print}' $OUT > ${OUT}.tmp
mv ${OUT}.tmp $OUT






