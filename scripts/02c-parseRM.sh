#!/bin/bash
#SBATCH --job-name=parseRM
#SBATCH --partition=pibu_el8
#SBATCH --time=02:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/parseRM_%J.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/parseRM_%J.err

# Directories and files

WORKDIR="/data/users/ncharriere/TE_annotation"
INPUTDIR="$WORKDIR/results/EDTA_annotation"
GENOME="ERR11437324_Altai-5.fa"
RMOUT="${INPUTDIR}/${GENOME}.mod.EDTA.anno/${GENOME}.mod.out"
PARSER="/data/courses/assembly-annotation-course/CDS_annotation/scripts/05-parseRM.pl"
OUTDIR="$WORKDIR/results/parseRM_results"

# Create directories if they don't exist
mkdir -p "$OUTDIR"

# Load required modules
module load BioPerl/1.7.8-GCCcore-10.3.0

# Run parser
cd "$INPUTDIR" || exit 1
perl "$PARSER" -i "$RMOUT" -l 50,1 -v

# Move output files
mv ${GENOME}.mod.EDTA.anno/${GENOME}.mod.out.landscape.*.tab "$OUTDIR/" 2>/dev/null

echo "Results are in: $OUTDIR"
