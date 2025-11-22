#!/bin/bash
#SBATCH --job-name=Merge_Maker
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G
#SBATCH --time=01:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Merge_Maker_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Merge_Maker_%x_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
cd /data/users/ncharriere/TE_annotation/annotation_directory

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
$MAKERBIN/gff3_merge -s -d /data/users/ncharriere/TE_annotation/annotation_directory/ERR11437324_Altai-5.maker.output/ERR11437324_Altai-5_master_datastore_index.log > assembly.all.maker.gff
$MAKERBIN/gff3_merge -n -s -d /data/users/ncharriere/TE_annotation/annotation_directory/ERR11437324_Altai-5.maker.output/ERR11437324_Altai-5_master_datastore_index.log > assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d /data/users/ncharriere/TE_annotation/annotation_directory/ERR11437324_Altai-5.maker.output/ERR11437324_Altai-5_master_datastore_index.log -o assembly
