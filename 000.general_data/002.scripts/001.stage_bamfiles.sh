#!/usr/bin/sh

# stage rawdata bamfiles from rawdata repository to scratch-cbe

# SLURM #
#SBATCH --output 999.logs/stage_bamfiles.log
#SBATCH --time=02:00:00
#SBATCH --mem=20GB

SAMPLES=/groups/nordborg/projects/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/000.general_data/001.data/samples.txt
BAMFILES=($(awk 'NR>1 {if($11 == "yes"){print $10}}' $SAMPLES))

TARGET=/scratch-cbe/users/pieter.clauw/003.transcriptome/001.8accessions/000.general_data/001.data/001.bamfiles/
BAMlst=${TARGET}bam_list.txt
mkdir -p $TARGET

for BAM in ${BAMFILES[@]}; do
    cp -v $BAM $TARGET
done

# create list of all bamfiles
ls ${TARGET}*.bam > $BAMlst

