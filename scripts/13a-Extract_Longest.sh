#!/bin/bash
#SBATCH --job-name=Extract_Longest_BUSCO
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=5
#SBATCH --mem=30G
#SBATCH --time=10:00:00
#SBATCH --output=/data/users/ncharriere/TE_annotation/logs/Extract_Longest_BUSCO_%x_%j.out
#SBATCH --error=/data/users/ncharriere/TE_annotation/logs/Extract_Longest_BUSCO_%x_%j.err

# === Créer le dossier logs si nécessaire ===
mkdir -p logs

# === Répertoires et fichiers ===
WORKDIR="/data/users/ncharriere/TE_annotation/annotation_directory/final"
MERGEDIR="/data/users/ncharriere/TE_annotation/annotation_directory/Merge_Maker_output"

cd $WORKDIR

protein="$WORKDIR/assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
transcript="$WORKDIR/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta"

# === Charger Python ===
module load Python/3.9.5-GCCcore-10.3.0

# === Vérifier Biopython, l'installer si absent ===
python -c "import Bio" 2>/dev/null || python -m pip install --user biopython

echo "Extraction de la plus longue isoforme par gène"

python <<EOF
from Bio import SeqIO

def get_longest_per_gene(in_fasta, out_fasta):
    best = {}
    for record in SeqIO.parse(in_fasta, "fasta"):
        gene = record.id.split("-R")[0]
        if gene not in best or len(record.seq) > len(best[gene].seq):
            best[gene] = record
    SeqIO.write(best.values(), out_fasta, "fasta")

get_longest_per_gene("$protein", "maker_proteins.longest.fasta")
get_longest_per_gene("$transcript", "maker_transcripts.longest.fasta")
EOF

echo "Extraction terminée"

# === Lancer BUSCO ===
module load BUSCO/5.4.2-foss-2021a

echo "Lancement de BUSCO sur les protéines"
busco -i maker_proteins.longest.fasta -l brassicales_odb10 -o busco_protein -m proteins

echo "Lancement de BUSCO sur les transcrits"
busco -i maker_transcripts.longest.fasta -l brassicales_odb10 -o busco_transcript -m transcriptome

echo "Terminé"
