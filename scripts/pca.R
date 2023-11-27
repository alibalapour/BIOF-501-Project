library(plyr)
library(ggplot2)

# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 1) {
    stop("Usage: Rscript preprocess.R <dataset_path>")
}

# Extract arguments
exprMatrix_path <- args[1]
pca_bar_plot_path <- args[2]

# Read saved dataset
exprMatrix <- readRDS(exprMatrix_path)

pca_res <- prcomp(exprMatrix, scale. = TRUE)
autoplot(pca_res)

png("Results/pca_barchart.png", width = 1000, height = 500)
plot(pca_res)
dev.off()