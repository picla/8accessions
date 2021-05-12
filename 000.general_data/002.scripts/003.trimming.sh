#!/bin/sh

# SLURM #
#SBATCH --output 999.logs/trim_galore_%A_%a.log
#SBATCH --time=01:00:00
#SBATCH --mem=1GB
#SBATCH --array=1-95:2

# MODULES #
ml trim_galore/0.6.2-foss-2018b-python-3.6.6

# DATA #
end1=$SLURM_ARRAY_TASK_ID
end2=$(expr $end1 + 1)
DATAdir=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/000.general_data/001.data
OUTdir=${DATAdir}/003.fastq_trimmed/
FASTQlst=${DATAdir}/002.fastqfiles/FASTQ_list.txt
# ls ${DATAdir}/002.fastqfiles/*.fastq > $FASTQlst

# take fastqs from fastqList.txt
FASTQ1=$(sed "${end1}q;d" $FASTQlst)
FASTQ2=$(sed "${end2}q;d" $FASTQlst)

# start trim_galor
echo 'starting trim_galore on files:'
echo $FASTQ1
echo $FASTQ2

trim_galore -q 10 \
	--fastqc \
	--output_dir $OUTdir \
	--phred33 \
	--paired \
	--nextera \
	$FASTQ1 $FASTQ2

