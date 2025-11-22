#!/bin/bash
#SBATCH --job-name=TEsorter_annotation
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=2-00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/TEsorter_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/TEsorter_%x_%j.err

WORKDIR=/data/users/ncharriere/TE_annotation/results/EDTA_annotation

apptainer exec \
    --bind $WORKDIR \
    /data/users/ncharriere/TE_annotation/data/TEsorter_1.3.0.sif \
    TEsorter \
    /data/users/ncharriere/TE_annotation/results/EDTA_annotation/ERR11437324_Altai-5.fa.mod.EDTA.raw/ERR11437324_Altai-5.fa.mod.LTR.raw.fa -db rexdb-plant