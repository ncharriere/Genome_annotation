#!/bin/bash
#SBATCH --job-name=BUSCO
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=5
#SBATCH --mem=16G
#SBATCH --time=05:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/BUSCO_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/BUSCO_%x_%j.err

# Directories
WORKDIR="/data/users/ncharriere/TE_annotation"
ANNODIR="$WORKDIR/annotation_directory"
OUTDIR="$ANNODIR/final/busco_plot"

GENOME_BUSCO="$ANNODIR/final/busco_protein"
TRANSCRIPTOME_BUSCO="$ANNODIR/final/busco_transcript"

mkdir -p "$OUTDIR/combined_summaries"

# Load BUSCO
module load BUSCO/5.4.2-foss-2021a

# Generate individual plots
for dataset in "$GENOME_BUSCO" "$TRANSCRIPTOME_BUSCO"; do
    generate_plot.py -wd "$dataset"
done

# Collect all short_summary files
for src in "$GENOME_BUSCO" "$TRANSCRIPTOME_BUSCO"; do
    cp "$src"/short_summary*.txt "$OUTDIR/combined_summaries/"
done

# Rename files for clarity
cd "$OUTDIR/combined_summaries"
for file in *busco_protein*; do mv "$file" "${file//busco_protein/annotation_protein}"; done
for file in *busco_transcript*; do mv "$file" "${file//busco_transcript/annotation_transcript}"; done

echo "=== Files after renaming ==="
ls -la

# Generate combined plot
generate_plot.py -wd "$OUTDIR/combined_summaries"
