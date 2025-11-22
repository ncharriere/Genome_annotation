#!/bin/bash
#SBATCH --job-name=TEsorter
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/TEsorter_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/TEsorter_%x_%j.err

WORKDIR="/data/users/ncharriere/TE_annotation/"

apptainer exec --bind $WORKDIR /data/users/ncharriere/TE_annotation/data/containers/TEsorter_1.3.0.sif TEsorter /data/users/ncharriere/TE_annotation/results/EDTA_annotation/TEsorter/Copia_sequences.fa -db rexdb-plant

apptainer exec --bind $WORKDIR /data/users/ncharriere/TE_annotation/data/containers/TEsorter_1.3.0.sif TEsorter /data/users/ncharriere/TE_annotation/results/EDTA_annotation/TEsorter/Gypsy_sequences.fa -db rexdb-plant