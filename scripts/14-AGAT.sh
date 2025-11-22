#!/bin/bash
#SBATCH --job-name=AGAT
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=01:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/AGAT_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/AGAT_%x_%j.err

WORKDIR="/data/users/ncharriere/TE_annotation/annotation_directory/final"
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/agat_1.5.1--pl5321hdfd78af_0.sif"

cd $WORKDIR

apptainer exec --bind /data "$CONTAINER" agat_sp_statistics.pl -i filtered.genes.renamed.gff3 -o annotation.stat

