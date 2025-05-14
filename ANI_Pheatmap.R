library(ComplexHeatmap)
library(circlize)
library(grid)

# Define matrix (12x12)
ani_matrix <- matrix(c(
  100.00, 99.23, 99.24, 99.24, 100.00, 99.23, 99.24, 99.24, 100.00, 99.23, 99.24, 99.24,
  99.23, 100.00, 99.24, 99.24, 99.23, 100.00, 99.24, 99.24, 99.23, 100.00, 99.24, 99.24,
  99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00,
  99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00,
  100.00, 99.23, 99.24, 99.24, 100.00, 99.23, 99.24, 99.24, 100.00, 99.23, 99.24, 99.24,
  99.23, 100.00, 99.24, 99.24, 99.23, 100.00, 99.24, 99.24, 99.23, 100.00, 99.24, 99.24,
  99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00,
  99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00,
  100.00, 99.23, 99.24, 99.24, 100.00, 99.23, 99.24, 99.24, 100.00, 99.23, 99.24, 99.24,
  99.23, 100.00, 99.24, 99.24, 99.23, 100.00, 99.24, 99.24, 99.23, 100.00, 99.24, 99.24,
  99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00,
  99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00, 99.24, 99.24, 100.00, 100.00
), nrow = 12, byrow = TRUE)

# Strain names
strain_names <- paste0("E.coli_", 1:12)
rownames(ani_matrix) <- colnames(ani_matrix) <- strain_names

# Metadata (12 entries)
Pathotype <- c("pathogenic", "pathogenic", "non-pathogenic", "non-pathogenic",
               "pathogenic", "pathogenic", "non-pathogenic", "non-pathogenic",
               "pathogenic", "pathogenic", "non-pathogenic", "non-pathogenic")
Source <- c("clinical", "clinical", "clinical", "waste water", 
            "baboons", "baboons", "waste water", "clinical",
            "clinical", "clinical", "baboons", "waste water")

# Annotation colors
group_colors <- c("pathogenic" = "#E41A1C", "non-pathogenic" = "#377EB8")
source_colors <- c("clinical" = "#4DAF4A", "waste water" = "#984EA3", "baboons" = "#FF7F00")

# Heatmap annotations
ha <- HeatmapAnnotation(
  Pathotype = Pathotype,
  Source = Source,
  col = list(Pathotype = group_colors, Source = source_colors),
  annotation_legend_param = list(
    Pathotype = list(title = "Pathotype"),
    Source = list(title = "Sample Source")
  )
)

# Color function
col_fun <- colorRamp2(c(50, 98, 99, 100), c("purple", "lightgreen", "yellow", "red"))

# Draw heatmap
Heatmap(
  ani_matrix,
  name = "ANI",
  top_annotation = ha,
  clustering_distance_rows = "euclidean",
  clustering_method_rows = "complete",
  clustering_distance_columns = "euclidean",
  clustering_method_columns = "complete",
  col = col_fun,
  cluster_rows = TRUE,
  cluster_columns = TRUE,
  row_dend_side = "left",
  column_dend_side = "top",
  row_names_side = "left",
  column_names_side = "top",
  show_row_dend = TRUE,
  show_column_dend = TRUE,
  cell_fun = function(j, i, x, y, width, height, fill) {
    grid.text(sprintf("%.2f", ani_matrix[i, j]), x, y, gp = gpar(fontsize = 8))
  }
)
