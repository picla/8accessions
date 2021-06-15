#!/usr/bin/env bash

# SLURM
#SBATCH --output=999.logs/quantification_salmon_%A_%a.log
#SBATCH --time=02:00:00
#SBATCH --mem=20GB
#SBATCH --cpus-per-task=4
#SBATCH --array=1-48

# MODULES #
ml salmon/1.2.1-foss-2018b

# DATA #
i=$SLURM_ARRAY_TASK_ID
WORK=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/
SAMPLES=/groups/nordborg/projects/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/000.general_data/001.data/samples.txt
FASTQdir=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/000.general_data/001.data/001.fastq_trimmed/
RESULTSdir=${WORK}003.results/001.quantification_salmon/

# Select accessions and index
BASE=$(awk '$11 == "yes" {print $5}' $SAMPLES | sed -n ${i}p)
ACN=$(awk '$11 == "yes" {print $2}' $SAMPLES | sed -n ${i}p)
OUTdir=${RESULTSdir}${BASE}_quantification_salmon/
#sample=$(echo $base | grep -o -E '[0-9]{5}_')
#sample=${sample%'_'}
#acn=$(awk -v sample="$sample" '$1==sample {print $2}' $SAMPLES)

INDEX=${WORK}001.data/004.indices/salmonIndex_${ACN}

# select fastq files of given sample
END1=${FASTQdir}${BASE}.end1_val_1.fq
END2=${FASTQdir}${BASE}.end2_val_2.fq

# PREP #
mkdir -p $OUTdir

salmon quant -i $INDEX -l ISR --seqBias --gcBias --writeUnmappedNames --validateMappings --rangeFactorizationBins 4 \
	-p 4 \
	-1 $END1 \
	-2 $END2 \
	-o $OUTdir


