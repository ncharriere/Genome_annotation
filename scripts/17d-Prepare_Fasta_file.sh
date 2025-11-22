#!/bin/bash
#SBATCH --job-name=fasta_file_genespace_only
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=12
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=working/logs/fasta_file_genespace_%j.out
#SBATCH --error=working/logs/fasta_file_genespace_%j.err

# ===========================
# Configuration
# ===========================
GENESPACE_DIR="/data/users/ncharriere/TE_annotation/annotation_directory/GENESPACE"
LIAN_PROTEIN="/data/courses/assembly-annotation-course/CDS_annotation/data/Lian_et_al/protein/selected/"
ACCESSIONS=("Taz_0" "Are_6" "Etna_2" "Ice_1" "Est_0" "Kar_1")

echo "[$(date)] Starting peptide FASTA generation for GENESPACE"
echo "Output directory: ${GENESPACE_DIR}/peptide"
echo "----------------------------------------------------------"

# ===========================
# Main loop (FASTA only)
# ===========================
for ACC in "${ACCESSIONS[@]}"; do
    ACC_DASH="${ACC//_/-}"
    PROT="${LIAN_PROTEIN}/${ACC_DASH}.protein.faa"
    PROT=$(ls "${PROT}" 2>/dev/null | head -n 1 || true)

    # --- Vérification de présence du fichier ---
    if [[ -z "${PROT}" || ! -f "${PROT}" ]]; then
        echo "error: [$(date +%H:%M:%S)] Skipping ${ACC}: protein file not found (${ACC_DASH}.protein.faa)"
        continue
    fi

    echo "[$(date +%H:%M:%S)] Processing ${ACC} from ${PROT}"

    # --- Conversion du fichier FASTA ---
    awk '
    /^>/ {
        if(seq != "") print seq;
        id = substr($1, 2);
        sub(/-R.*/, "", id);
        sub(/\.[0-9]+$/, "", id);
        gsub(/[:.-]/, "_", id);
        print ">" id;
        seq = "";
        next;
    }
    {
        gsub(/[^A-Za-z*]/, "", $0);
        seq = seq $0;
    }
    END {
        if(seq != "") print seq;
    }' "${PROT}" > "${GENESPACE_DIR}/peptide/${ACC}.fa"

    if [[ $? -eq 0 ]]; then
        echo "[$(date +%H:%M:%S)] Created ${GENESPACE_DIR}/peptide/${ACC}.fa"
    else
        echo "[$(date +%H:%M:%S)] Error while processing ${ACC}"
    fi

done

echo "----------------------------------------------------------"
echo "[$(date)] Peptide FASTA generation completed."
echo "Generated: $(ls ${GENESPACE_DIR}/peptide/*.fa 2>/dev/null | wc -l) files"
