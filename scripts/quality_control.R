suppressMessages(library("Biobase"))
suppressMessages(library("limma"))

# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 1) {
    stop("Usage: Rscript quality_control.R <dataset_path>")
}

# Extract arguments
dataset_path <- args[1]

# Read saved dataset
dataset <- readRDS(dataset_path)

# Generate expression matrix
exprMatrix = exprs(dataset)

# calculating statistics
print(paste0("max : ", max(exprMatrix)))
print(paste0("min : ", min(exprMatrix)))
print(paste0("mean : ", mean(exprMatrix)))
print(paste0("std : ", sd(exprMatrix)))

# Save expression matrix
saveRDS(dataset, "Results/expr_mat")

# Save generated box plot on expression data
png("Results/expr_box_plot.png", width = 1000, height = 500)
boxplot(exprs(dataset))
dev.off()