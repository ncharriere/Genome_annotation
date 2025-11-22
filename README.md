# Organization and Annotation of Eukaryote Genomes
**Student**: Charrière Noé
## UE-SBL.30004 — AS-2025
This repository contains all the work completed for the course Organization and Annotation of Eukaryote Genomes (UE-SBL.30004) at the University Fribourg.  
This project focuses on the structural and functional annotation of the Altai-5 genome, using standard bioinformatics tools and reproducible workflows.  
  
You will find in this repositery all the scripts used throughout the analyses, as well as a report summarizing the main results.
## Project Overview
The aim of this project is to explore the genomic organization of the *Arabidopsis thaliana* organism and perform a full annotation workflow. I specifically worked on Altai-5 organism.  
  
The data used in this project originate from Lian et al. (2024) who published the pan-genome of 69 Arabidopsis thaliana accessions. We re-analysed their dataset in the context of the course. [DOI: 10.1038/s41588-024-01715-9]
The dataset is the ERR11437324_Altai-5.fa from Lian et al. (2024) and was compared with the accession Etna-2; Ice-1; Taz-0; TAIR10 from the same paper.
  
The structure of this work is the following:
- Annotation and classification of transposable elements
    - EDTA: Genome-wide TE annotation and composition analysis by TE categories and families
    - TEsorter: Fine-scale TE classification using consensus sequences
    - Dynamic analyses: Estimation of LTR retrotransposon insertion ages to identify expansion peaks
- Gene annotation using the MAKER pipeline
    - MAKER: Structural gene prediction
    - Filtering and functional annotation: AED-based filtering followed by InterProScan
    - Quality assessment: BUSCO (completeness based on universal single-copy genes) and AGAT (genome-wide statistics including gene density)
- Orthology-based gene functional annotation and genome comparisons
    - Functional annotation through orthology inference using OrthoFinder
    - GENESPACE: Genome comparison and synteny analysis
## Repository Structure

| File / Folder | Description |
|--------------|-------------|
| `scripts/`   | All scripts used for the analysis (Bash, Python, R). |
| `data/`      | Input data (genome, reference proteins, annotation databases, etc.). |
| `report/`    | Final written report containing detailed results, figures, and interpretations. |
| `README.md`  | Overview and documentation of the project. |
  
**Note:** Only the scripts necessary to reproduce the final analyses are included.  
Some scripts from intermediate steps have been omitted for brevity, so the numbering may not be consecutive.

## Tools used
- **EDTA v2.2**: Genome-wide TE annotation and composition analysis
- **TEsorter v1.3.0**: Fine-scale TE classification using consensus sequences
- **MAKER v3.01.03**: Structural gene prediction
- **RepeatMasker**: Genome repeat masking
- **AUGUSTUS v3.4.0**: Gene prediction used by MAKER
- **OpenMPI v4.1.1**: Parallel execution of MAKER
- **InterProScan (latest)**: Protein domain annotation and GO term assignment
- **MAKER auxiliary scripts** (ipr_update_gff, AED_cdf_generator.pl, quality_filter.pl): GFF update, AED calculation, and quality filtering
- **UCSC faSomeRecords**: Extract sequences from FASTA files by list of IDs
- **MariaDB v10.6.4**: Database backend required by UCSC utilities
- **Python v3.9.5**: Used for custom scripts processing FASTA sequences
- **Biopython**: Library to parse and manipulate FASTA sequences
- **BUSCO v5.4.2**: Benchmarking Universal Single-Copy Orthologs; completeness assessment of gene annotation
- **BLAST+ v2.15.0**: Protein similarity searches against UniProt and TAIR10 databases
- **MAKER auxiliary tools** (maker_functional_fasta, maker_functional_gff): Functional annotation based on BLAST hits
- **GENESPACE (latest)**: Comparative genomics and synteny analysis
- **R / Rscript**: Required to run GENESPACE pipeline
- **Apptainer / Singularity**: Containerized execution for reproducibility
- **GENESPACE (R package, latest)**: Comparative genomics, synteny analysis, pangenome inference
- **MCScanX**: Collinearity and synteny detection engine used by GENESPACE
- **R / Rscript**: Execution of GENESPACE scripts
- **Bash / awk**: Processing and cleaning protein FASTA files for GENESPACE input
- **SLURM**: Job scheduling and resource allocation on the cluster


## How to run scripts
**Execution environment:** Analyses were performed on the University of Bern HPC cluster (`hpc.binf.unibe.ch`) using SLURM for job scheduling. All tools were run via Apptainer/Singularity containers to ensure reproducibility and a consistent software environment.

## Github functions
- git add #nom du fichier/directory
- git commit -m "#expliquer ce que c'est"
- git push
- git pull (pour revenir en arrièreet importer depuis github une modif)
