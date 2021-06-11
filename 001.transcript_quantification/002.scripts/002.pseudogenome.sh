#!/usr/bin/env bash

# SLURM
#SBATCH --output=999.logs/pseudotranscriptome_%A_%a.log
#SBATCH --time=12:00:00
#SBATCH --mem=10GB
#SBATCH --array=1-6


# MODULES #
ml python/3.8.6-gcccore-10.2.0
# copy script from /projects/cegs/6vs16/Scripts/make_pseudogenome_fasta.py
PSEUDOGENIZE=${WORK}Transcriptome/6vs16/Scripts/make_pseudogenome_fasta.py 

# DATA #
i=$PBS_ARRAY_INDEX
mainDir=${WORK}Transcriptome/6vs16/Data/Genome/
FASTA=${mainDir}TAIR10_genome.fasta
VCFlst=${mainDir}vcf_for_pseudoGenome.txt
VCF=${mainDir}$(sed -n ${i}p $VCFlst)
OUT=${VCF/intersection/pseudoTAIR10}
OUT=${OUT/.vcf/.fasta}

# MAKE PSEUDO GENOMES #
python $PSEUDOGENIZE -O $OUT $FASTA $VCF

awk '/>[0-9]/{gsub(/>/,">Chr")}{print}' $OUT > ${OUT}.tmp
mv ${OUT}.tmp $OUT






