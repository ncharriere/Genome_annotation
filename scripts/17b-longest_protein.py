#!/usr/bin/env python3
"""
extract_longest_proteins.py
Extract longest protein sequence per gene from a FASTA file and clean headers for GENESPACE.
"""

from Bio import SeqIO
import re
import sys

if len(sys.argv) != 3:
    print("Usage: python extract_longest_proteins.py proteins.fasta Accession")
    sys.exit(1)

fasta_file = sys.argv[1]
accession = sys.argv[2]

longest = {}
for record in SeqIO.parse(fasta_file, "fasta"):
    # Extract gene ID: keep only the prefix (e.g., ALT0035919) for GENESPACE
    match = re.match(r'^([A-Za-z]+[0-9]+)', record.id)
    if not match:
        print(f"Warning: could not parse gene ID from {record.id}")
        continue
    gene_id = match.group(1)

    # Keep the longest isoform per gene
    if gene_id not in longest or len(record.seq) > len(longest[gene_id].seq):
        # Update header to the cleaned gene ID
        record.id = gene_id
        record.description = ""
        longest[gene_id] = record

# Write output FASTA
output_file = f"{accession}.fa"
with open(output_file, "w") as out_fa:
    SeqIO.write(longest.values(), out_fa, "fasta")

print(f"Wrote {len(longest)} longest protein sequences to {output_file}")


# run with:
# python /data/users/ncharriere/TE_annotation/scripts/17b-longest_protein.py /data/users/ncharriere/TE_annotation/annotation_directory/final/maker_proteins.longest.fasta Altai_5