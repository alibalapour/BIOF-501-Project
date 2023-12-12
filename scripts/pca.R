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

# Extract principle components
pca_res <- prcomp(exprMatrix, scale. = TRUE)

# PCA plot with labels
png(file.path(result_dir_path, "pca_scatter_plot.png"), width = 512, height = 512)
pcar <- data.frame(pca_res$rotation [,1:3] , group = groupedSamples)
ggplot(pcar , aes(PC1 , PC2 , color = group , size = 4)) + geom_point()+ theme_bw()
dev.off()

# tSNE plot with labels
png(file.path(result_dir_path, "tsne_scatter_plot.png"), width = 512, height = 512)
tsne(exprMatrix, dotsize = 3, labels = groupedSamples, printheight = 20, printwidth = 22,scale = 1)
dev.off()

# tSNE plot with labels
png(file.path(result_dir_path, "umap_scatter_plot.png"), width = 512, height = 512)
umap(exprMatrix, dotsize = 3, labels = groupedSamples, printheight = 20, printwidth = 22,scale = 1)
dev.off()
