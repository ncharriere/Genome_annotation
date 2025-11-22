#!/bin/bash
#SBATCH --job-name=Prepare_Genespace
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=2
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Prepare_Genespace_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Prepare_Genespace_%x_%j.err

workingDirectory="/data/users/ncharriere/TE_annotation/annotation_directory/GENESPACE"
cd "$workingDirectory" || exit

echo "Starting BED extraction..."

# ACCESSIONS TO PROCESS
declare -A ACCESSIONS=(
    ["Altai-5"]="/data/users/ncharriere/TE_annotation/annotation_directory/final/filtered.genes.renamed.gff3"
    ["Etna-2"]="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected/Etna-2.EVM.v3.5.ann.protein_coding_genes.gff"
    ["Taz-0"]="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected/Taz-0.EVM.v3.5.ann.protein_coding_genes.gff"
    ["Are-6"]="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected/Are-6.EVM.v3.5.ann.protein_coding_genes.gff"
    ["Ice-1"]="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected/Ice-1.EVM.v3.5.ann.protein_coding_genes.gff"
    ["Est-0"]="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected/Est-0.EVM.v3.5.ann.protein_coding_genes.gff"
    ["Kar-1"]="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/gene_gff/selected/Kar-1.EVM.v3.5.ann.protein_coding_genes.gff"
)
# Les fichiers de données du cours ne sont pas inclus dans le Github

# LOOP OVER ACCESSIONS
for acc in "${!ACCESSIONS[@]}"; do
    gff="${ACCESSIONS[$acc]}"

    echo "Processing $acc..."

    if [[ ! -f "$gff" ]]; then
        echo "GFF file not found: $gff"
        continue
    fi

    # Extract gene lines
    grep -P "\tgene\t" "$gff" > "temp_${acc}.gff3"

    # Convert to BED
    awk 'BEGIN{OFS="\t"} {split($9,a,";"); split(a[1],b,"="); print $1, $4-1, $5, b[2]}' \
        "temp_${acc}.gff3" > "${acc}.bed"

    echo "BED created: ${acc}.bed"
done

echo "Everything finished"