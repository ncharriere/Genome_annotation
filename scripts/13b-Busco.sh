#!/bin/bash
#SBATCH --job-name=BUSCO
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=5
#SBATCH --mem=30G
#SBATCH --time=05:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/BUSCO_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/BUSCO_%x_%j.err

module load BUSCO/5.4.2-foss-2021a

echo "Lancement de BUSCO sur les protéines"
busco -i maker_proteins.longest.fasta -l brassicales_odb10 -o busco_protein -m proteins -f

echo "Lancement de BUSCO sur les transcrits"
busco -i maker_transcripts.longest.fasta -l brassicales_odb10 -o busco_transcript -m transcriptome -f

echo "Terminé"