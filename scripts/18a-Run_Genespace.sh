#!/bin/bash
#SBATCH --job-name=Run_Genespace
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Run_Genespace_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Run_Genespace_%x_%j.err

#Step 3: Run GENESPACE
##To run GENESPACE, you need to prepare the an Rscript as above that you can run using the singulariy container as follows
export SCRATCH=/data/users/ncharriere/scratch
mkdir -p $SCRATCH

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/ncharriere/TE_annotation"

apptainer exec \
    --bind /data \
    --bind ${SCRATCH}:/temp \
    $COURSEDIR/containers/genespace_latest.sif Rscript $WORKDIR/scripts/18b-genespace.R $WORKDIR/annotation_directory/GENESPACE/

echo "Job finished at $(date)"


