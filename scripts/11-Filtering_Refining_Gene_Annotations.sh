#!/bin/bash
#SBATCH --job-name=Filtering_Refining_Gene_Annotations
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Filtering_Refining_Gene_Annotations_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Filtering_Refining_Gene_Annotations_%x_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"
WORKDIR="/data/users/ncharriere/TE_annotation/annotation_directory/final"
prefix="ALT"

cd /data/users/ncharriere/TE_annotation/annotation_directory/final


# 1. Rename Genes and Transcripts
echo "etape 1"
$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > id.map
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta
#$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta

# 2. Run InterProScan on the Protein File
echo "etape 2"
apptainer exec \
    --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data \
    --bind $WORKDIR \
    --bind $COURSEDIR \
    --bind $SCRATCH:/temp \
    $COURSEDIR/containers/interproscan_latest.sif \
    /opt/interproscan/interproscan.sh \
    -appl pfam --disable-precalc -f TSV \
    --goterms --iprlookup --seqtype p \
    -i ${protein}.renamed.fasta -o output.iprscan

# 3. Update GFF with InterProScan Results
echo "etape 3"
$MAKERBIN/ipr_update_gff ${gff}.renamed.gff output.iprscan > ${gff}.renamed.iprscan.gff

# 4. Calculate AED Values
echo "etape 4"
perl $MAKERBIN/AED_cdf_generator.pl -b 0.025 ${gff}.renamed.gff > assembly.all.maker.renamed.gff.AED.txt

# 5. Filter the GFF File for Quality
echo "etape 5"
perl $MAKERBIN/quality_filter.pl -s ${gff}.renamed.iprscan.gff > ${gff}_iprscan_quality_filtered.gff
    # In the above command: -s Prints transcripts with an AED <1 and/or Pfam domain if in gff3

# 6. Filter the GFF File for Gene Features
echo "etape 6"
# We only want to keep gene features in the third column of the gff file
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" ${gff}_iprscan_quality_filtered.gff > filtered.genes.renamed.gff3
# Check
cut -f3 filtered.genes.renamed.gff3 | sort | uniq

# 7. Extract mRNA Sequences and Filter FASTA Files
echo "etape 7"
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0
grep -P "\tmRNA\t" filtered.genes.renamed.gff3 | awk '{print $9}' | cut -d';' -f1 | sed 's/ID=//g' > list.txt
faSomeRecords ${transcript}.renamed.fasta list.txt ${transcript}.renamed.filtered.fasta
faSomeRecords ${protein}.renamed.fasta list.txt ${protein}.renamed.filtered.fasta

