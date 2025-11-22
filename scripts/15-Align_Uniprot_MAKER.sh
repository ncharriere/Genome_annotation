#!/bin/bash
#SBATCH --job-name=Align_UniProt
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Align_UniProt_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Align_UniProt_%x_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"

module load BLAST+/2.15.0-gompi-2021a
blastp_output="/data/users/ncharriere/TE_annotation/annotation_directory/final/Align_UniProt/blastp_output.txt"
## makeblastb -in /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -dbtype prot # this step is already done
blastp -query /data/users/ncharriere/TE_annotation/annotation_directory/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out ${blastp_output}
## Now sort the blast output to keep only the best hit per query sequence
sort -k1,1 -k12,12g ${blastp_output} | sort -u -k1,1 --merge > ${blastp_output}.besthits

echo "part MAKER"

cp /data/users/ncharriere/TE_annotation/annotation_directory/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta maker_proteins.filtered.fasta.Uniprot
cp /data/users/ncharriere/TE_annotation/annotation_directory/final/filtered.genes.renamed.gff3 filtered.maker.gff3.Uniprot.gff3
$MAKERBIN/maker_functional_fasta /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa ${blastp_output}.besthits /data/users/ncharriere/TE_annotation/annotation_directory/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta > maker_proteins.filtered.fasta.Uniprot
$MAKERBIN/maker_functional_gff /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa ${blastp_output} /data/users/ncharriere/TE_annotation/annotation_directory/final/filtered.genes.renamed.gff3 > filtered.maker.gff3.Uniprot.gff3

echo "TAIR10"

blastp -query /data/users/ncharriere/TE_annotation/annotation_directory/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta -db /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_pep_20110103_representative_gene_model -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out blastp_TAIR10_output
# Now sort the blast output to keep only the best hit per query sequence
sort -k1,1 -k12,12g blastp_TAIR10_output | sort -u -k1,1 --merge > blastp_TAIR10_output.besthits