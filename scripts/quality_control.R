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

exprMatrix = exprs(dataset)

# calculating statistics
print(paste0("max : ", max(exprMatrix)))
print(paste0("min : ", min(exprMatrix)))
print(paste0("mean : ", mean(exprMatrix)))
print(paste0("std : ", sd(exprMatrix)))

# boxplot(exprs(dataset))