#!/usr/bin/env bash

# SLURM
#SBATCH --output=999.logs/pseudotranscriptome_%A_%a.log
#SBATCH --time=12:00:00
#SBATCH --mem=10GB
#SBATCH --array=1-6


# MODULES #
ml python/3.8.6-gcccore-10.2.0

PSEUDOGENIZE=002.scripts/002.pseudogenome.py

# DATA #
i=$SLURM_ARRAY_TASK_ID
WORK=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/
FASTA=${WORK}001.data/TAIR10_chr_all.fas


VCFlst=${mainDir}vcf_for_pseudoGenome.txt
VCF=${mainDir}$(sed -n ${i}p $VCFlst)
OUT=${VCF/intersection/pseudoTAIR10}
OUT=${OUT/.vcf/.fasta}

# MAKE PSEUDO GENOMES #
python $PSEUDOGENIZE -O $OUT $FASTA $VCF

awk '/>[0-9]/{gsub(/>/,">Chr")}{print}' $OUT > ${OUT}.tmp
mv ${OUT}.tmp $OUT






