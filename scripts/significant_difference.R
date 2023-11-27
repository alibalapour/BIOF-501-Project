suppressMessages(library("Biobase"))
suppressMessages(library(plyr))
suppressMessages(library(ggplot2))
library(pheatmap)
library(reshape2)
library(plyr)
library(ggfortify)
library(M3C)

# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 2) {
    stop("Usage: Rscript significant_difference.R <dataset_path> <result_dir_path>")
}

# Extract arguments
dataset_path <- args[1]
result_dir_path <- args[2]

# Read saved dataset
dataset <- readRDS(dataset_path)
groupedSamples <- readRDS(file.path(result_dir_path, "grouped_samples.rds"))
exprMatrix <- readRDS(file.path(result_dir_path, "expr_mat.rds"))

# Generate UMAP and PCA
umap_plot <- umap(exprMatrix, dotsize = 3, labels = groupedSamples)
pca_res <- prcomp(exprMatrix, scale. = TRUE)
pcar <- data.frame(pca_res$rotation [,1:3] , group = groupedSamples)



newGroup <- groupedSamples
newGroup[which((umap_plot$data$X2 > 0 & pcar$group == "test"))] <- "test_Near_CD34"

newGroup <- str_replace(newGroup, ' ', '_')

newGroup <- factor(newGroup)
dataset$group <- newGroup
design <- model.matrix(~newGroup + 0, dataset)
colnames(design) <- levels(newGroup)

# fit linear model
fit <- lmFit(dataset, design)

# set up contrasts of interest and recalculate model coefficients
cont.matrix <- makeContrasts(test_Near_CD34 - normal_CD34, levels=design)
fit2 <- contrasts.fit(fit, cont.matrix)

# compute statistics and table of top significant genes
fit2 <- eBayes(fit2, 0.01)
tT <- topTable(fit2, adjust="fdr", sort.by="B", number=250)

tT <- subset(tT, select=c("Gene.symbol" , "Gene.title", "adj.P.Val" , "logFC"))
write.table(tT, file=file.path(result_dir_path, 'stat_table.txt'), row.names=F, sep="\t")

table_subset <- subset(tT , logFC > 1 & adj.P.Val < 0.05)
genes_1 <-unique( as.character(strsplit2( (table_subset$Gene.symbol),"///")))
table_subset <- subset(tT , logFC < -1& adj.P.Val < 0.05)
genes_2 <- unique(as.character(strsplit2((table_subset$Gene.symbol),"///")))

write.table(
  genes_1,
  file.path(result_dir_path, "genes_1.txt"),
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

write.table(
  genes_2,
  file.path(result_dir_path, "genes_2.txt"),
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)
