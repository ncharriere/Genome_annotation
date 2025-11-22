#!/bin/bash
#SBATCH --job-name=EDTA_annotation
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --mem=200G
#SBATCH --time=2-00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs//%x_%j.err

WORKDIR=/data/users/ncharriere/TE_annotation
CONTAINER=$WORKDIR/data/EDTA2.2.sif
CDS_FILE=$WORKDIR/data/TAIR10_cds_20110103_representative_gene_model_updated
OUTDIR=$WORKDIR/results/EDTA_annotation

mkdir -p "$OUTDIR"
cd "$OUTDIR"


apptainer exec \
    --bind "$WORKDIR" \
    /data/courses/assembly-annotation-course/CDS_annotation/containers/EDTA2.2.sif \
    EDTA.pl \
    --genome "$WORKDIR/data/assemblies/ERR11437324_Altai-5.fa" \
    --species others \
    --step all \
    --sensitive 1 \
    --cds "$CDS_FILE" \
    --anno 1 \
    --threads $SLURM_CPUS_PER_TASK
