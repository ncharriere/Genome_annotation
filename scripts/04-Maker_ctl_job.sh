#!/bin/bash
#SBATCH --job-name=maker_ctl
#SBATCH --output=maker_ctl.out
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/maker_ctl_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/maker_ctl_%x_%j.err

export WORKDIR=/data/users/ncharriere/TE_annotation/annotation_directory
cd $WORKDIR

apptainer exec --bind $WORKDIR \
/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif maker -CTL