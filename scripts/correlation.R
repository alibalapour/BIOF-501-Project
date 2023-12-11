suppressMessages(library("Biobase"))
suppressMessages(library(plyr))
suppressMessages(library(ggplot2))
suppressMessages(library(pheatmap))
suppressMessages(library(reshape2))
suppressMessages(library(plyr))
suppressMessages(library(ggfortify))
suppressMessages(library(M3C))

# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 2) {
    stop("Usage: Rscript pca.R <exprMatrix_path> <result_dir_path>")
}

# Extract arguments
exprMatrix_path <- args[1]
grouped_samples_path <- args[2]
result_dir_path <- args[3]

# Read saved dataset
exprMatrix <- readRDS(exprMatrix_path)
groupedSamples <- readRDS(grouped_samples_path)

png(file.path(result_dir_path, "heatmap.png") , width = 1000, height = 1000)
pheatmap(cor(exprMatrix), labels_row = groupedSamples, labels_col = groupedSamples)
dev.off()