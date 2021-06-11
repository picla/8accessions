
# copy VCF to scratch
cp -up /groups/nordborg/projects/the1001genomes/release/VCFs/1001genomes_snp-short-indel_only_ACGTN.vcf.gz /scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/001.data/

# copy TAIR10 genome
cp -up /groups/nordborg/user/pieter.clauw/Documents/Source/TAIR10/TAIR10_chr_all.fas /scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/001.data/
TAIR10=/scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/001.data/TAIR10_chr_all.fas

# make chromosome names GTF compatible
# add Chr as prefix for chromosome names
awk '/>[0-9]/{gsub(/>/,">Chr")}{print}' $TAIR10 > ${TAIR10}.tmp
mv ${TAIR10}.tmp $TAIR10
awk '/>mitochondria/{gsub(/>mitochondria/,">ChrM")}{print}' $TAIR10 > ${TAIR10}.tmp
mv ${TAIR10}.tmp $TAIR10
awk '/>chloroplast/{gsub(/>chloroplast/,">ChrC")}{print}' $TAIR10 > ${TAIR10}.tmp
mv ${TAIR10}.tmp $TAIR10


# copy gtf
cp -up /groups/nordborg/user/pieter.clauw/Documents/Source/Araport11/Araport11_GFF3_genes_transposons.201606.gtf /scratch-cbe/users/pieter.clauw/cold_adaptation_16Cvs6C/003.transcriptome/001.8accessions/001.transcript_quantification/001.data/



