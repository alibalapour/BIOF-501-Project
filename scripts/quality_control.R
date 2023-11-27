suppressMessages(library("Biobase"))
suppressMessages(library("limma"))

# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 3) {
    stop("Usage: Rscript quality_control.R <dataset_path>")
}

# Extract arguments
dataset_path <- args[1]
result_dir_path <- args[2]


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
saveRDS(dataset, file.path(result_dir_path, "expr_mat.rds"))

# Save generated box plot on expression data
png(file.path(result_dir_path, "expr_box_plot.png"), width = 1000, height = 500)
boxplot(exprs(dataset))
dev.off()