#!/usr/bin/env bash

# SLURM
#SBATCH --mem=5GB
#SBATCH --time=03:00:00
#SBATCH --output=999.logs/subsetVCF_%A_%a.log
#SBATCH --array=0-6

ml vcftools/0.1.16-foss-2018b-perl-5.28.0

# DATA #
i=$SLURM_ARRAY_TASK_ID
WORK=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/
VCF=${WORK}001.data/001.vcf/1001genomes_snp-short-indel_only_ACGTN.vcf.gz

accessions=(6017 9728 9559 8242 9888 9433 9075)

acn=${accessions[$i]}

out=${VCF/.vcf.gz/_${acn}.vcf}
vcf-subset -c $acn $VCF > $out


