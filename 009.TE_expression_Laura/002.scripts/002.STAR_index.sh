#!/bin/sh

# SLURM #
#SBATCH --output 999.logs/STAR_index.log
#SBATCH --mem=3GB
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task=4

# MODULES #
ml star/2.7.1a-foss-2018b

# map RNA-seq reads to consensus TE sequences


# DATA #
mainDir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/009.TE_expression_Laura

# stage in
cp -v /groups/nordborg/projects/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/009.TE_expression_Laura/001.data/Ath_RepBase_TEs.fasta ${mainDir}/001.data/

FASTA=${mainDir}/001.data/Ath_RepBase_TEs.fasta
Indices=${mainDir}/001.data/001.TE_STAR_index

# PARAMETERS #
cores=4

# PREPARATION #
mkdir -p $Indices

# GENOME INDICES #

STAR \
--runThreadN $cores \
--runMode genomeGenerate \
--genomeDir $Indices \
--genomeFastaFiles $FASTA

# stage out
cp -rv $Indices /groups/nordborg/projects/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/009.TE_expression_Laura/001.data/



