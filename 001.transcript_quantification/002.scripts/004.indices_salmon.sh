#!/usr/bin/env bash

# script to build the transcriptome index for the Araport11 transcriptome that can be used for gene expression quantification with salmon (non-alignement based)

# SLURM
#SBATCH --output=999.logs/indices_salmon_%A_%a.log
#SBATCH --time=01:00:00
#SBATCH --mem=10GB
#SBATCH --array=0-7

# MODULES #
ml salmon/1.2.1-foss-2018b

# DATA #
i=$SLURM_ARRAY_TASK_ID
WORK=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/

accessions=(6909 6017 9728 9559 8242 9888 9433 9075)
acn=${accessions[$i]}

TRANSCRIPT=${WORK}001.data/pseudotranscriptome_${acn}.fasta
INDEX=${WORK}001.data/salmonIndex_${acn}

echo for accession $acn we are using transcriptome from: $TRANSCRIPT

# build index
salmon index -t $TRANSCRIPT -k 31 -i $INDEX --keepDuplicates

echo index for salmon quasi-mapping has been built and saved in $INDEX
