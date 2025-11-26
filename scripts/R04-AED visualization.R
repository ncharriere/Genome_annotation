######
# Annotation of genes with MAKER Pipeline
## Filtering and Refining Gene Annotations
### Calculate AED Values
####You can visualize the AED distribution using R.
#####

# Définir le chemin vers ton fichier AED et Lire les données
aed_file <- "/home/noech/Documents/UNIFR/Master in Ecology and Evolution/1) AS 2025/SBL.30004 - Organization and annotation of eukaryote genomes/assembly.all.maker.renamed.gff.AED.txt"
aed_data <- read.table(aed_file, header = TRUE)

# Vérifie le nom de la colonne contenant les valeurs AED
head(aed_data)
# Renommer les colonnes pour simplifier (si besoin)
colnames(aed_data) <- c("AED", "Cumulative")

# Tracer la courbe cumulative
plot(
  aed_data$AED,
  aed_data$Cumulative,
  type = "l",               # "l" = ligne
  lwd = 2,                  # épaisseur de ligne
  col = "blue",
  main = "Courbe cumulative des valeurs AED",
  xlab = "Annotation Edit Distance (AED)",
  ylab = "Proportion cumulée de gènes"
)

# Ajouter une ligne rouge à 0.5 pour le seuil
abline(v = 0.5, col = "red", lty = 2, lwd = 2)

# Ajouter un texte d’interprétation
text(0.52, 0.5, "Seuil AED = 0.5", col = "red", pos = 4)

# Définir les couleurs selon le seuil 0.5
colors <- ifelse(aed_data$AED <= 0.5, "lightblue", "lightgray")

# Tracer le barplot cumulatif avec couleurs conditionnelles
bp <- barplot(
  height = aed_data$Cumulative,
  names.arg = aed_data$AED,
  col = colors,
  border = "black",
  main = "Histogramme cumulatif des valeurs AED",
  xlab = "Annotation Edit Distance (AED)",
  ylab = "Proportion cumulée de gènes",
  las = 2
)

# Ajouter éventuellement une ligne verticale au seuil pour rappel
pos_0.5 <- bp[which.min(abs(aed_data$AED - 0.5))]
abline(v = pos_0.5, col = "red", lty = 2, lwd = 2)
text(pos_0.5 + 0.5, 0.5, "Seuil AED = 0.5", col = "red", pos = 4)

# Trouver l'indice de la valeur la plus proche de 0.5
idx <- which.min(abs(aed_data$AED - 0.5))

# Afficher la valeur exacte d'AED et la proportion cumulée correspondante
aed_data[idx, ]
