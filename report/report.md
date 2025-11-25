# Report - Organization and Annotation of Eukaryote Genomes

**Student**: Charrière Noé  

## Introduction  

This report summarizes the analyses performed during the “Organization and Annotation of Eukaryote Genomes” practical course.  
The goal was to perform transposable elements annotation and classification, annotation of genes with the MAKER Pipeline, orthology based gene functional annotation and genome comparisons.  
All commands and tool versions are documented in the README; this report focuses exclusively on the obtained results.  

## Results  

### Figure 01 - full LTR retrotransposon  

![Figure 01 - full LTR retrotransposon PDF](figures/01_LTR_Copia_Gypsy_cladelevel.pdf)  
Figure 01. *This figure shows the number of full-length LTR retrotransposons detected in the genome. These complete elements include both LTRs and internal coding domains, indicating potentially intact or recently active transposons. Their abundance highlights the important role of LTR elements in shaping genome structure and evolution.*  
  
### Figure 02 - TE landscape  

**Figure 02a - TE landscape**  

![Figure 02a - TE landscape PDF](figures/02a_TE_landscape.pdf)  

**Figure 02b - TE landscape with age**  

![Figure 02b - TE landscape with age PDF](figures/02b_TE_landscape_age.pdf)  
Figure 02. *These two figures show the distribution of transposable elements (TEs) in the genome: (a) based on their divergence from the consensus sequence, and (b) based on the estimated insertion age (in million years) using the substitution rate. The X-axis represents (a) percent divergence and (b) estimated insertion age, while the Y-axis shows the sequence amount in Mbp for each TE superfamily. Peaks at low divergence (or low age) indicate recent TE activity, whereas broader peaks at higher values reflect older waves of insertions.*  
  
### Figure 03 - Genome circular overview  

**Figure 03a - Contigs ordered by size**  

![Figure 03a - Contigs ordered by size](figures/03a-TE_and_genes_density_contigs_size.pdf)  
Figure 03a. *This circular plot shows the distribution of transposable elements (TEs) by superfamily and the proportion of genes across contigs, which are ordered by decreasing size. Each ring represents a different TE superfamily or gene density. Peaks indicate regions with higher TE or gene content. This view highlights the overall structure of the genome and major TE-rich or gene-rich regions. (I didn't put the intermediate versions without the gene density, it didn't add anything)*  

**Figure 03b - Contigs ordered by chromosomal location**  

![Figure 03b - Contigs ordered by chromosomal location](figures/03b-TE_and_genes_density_rearranged.pdf)  
Figure 03b. *Here, contigs are ordered according to their inferred chromosomal positions based on GENESPACE comparisons with TAIR10. This representation allows the identification of conserved genomic regions, showing how TE and gene distribution patterns relate to chromosome organization. Comparisons with Figure 03a illustrate the differences between size-based and chromosomal ordering.*  

**Figure 03c - TE and rRNA localization**  

![Figure 03c - TE and rRNA localization](figures/03c-TE_and_genes_density_rRNA.pdf)  
Figure 03c. *This circular plot overlays rRNA loci on the previous visualization. rRNAs are normally expected at two canonical locations (nucleolar organizer regions, NORs, on chromosomes 2 and 4), but additional expressed rRNA regions are observed in this genome.*  

**Figure 03d - Contigs ordered by chromosomal location with centromeres**  

![Figure 03d - Contigs ordered by chromosomal location with centromeres](figures/03d_circlize_presentation.pdf)  
Figure 03d. *This final circos plot builds on Figure 03b by adding the locations of centromeres (in blue) and chromosome boundaries (in red). Most centromeres appear split across different contigs, which is expected due to the highly repetitive nature of these regions.*  
  
