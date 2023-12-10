# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 1) {
    stop("Usage: Rscript download_data.R <series> <output_file>")
}

# Extract arguments
series <- args[1]
output_file <- args[2]


# # Set a new directory to install R packages
.libPaths( c( "~/R" , .libPaths() ) )

######
# Import packages
######
if (!require("BiocManager", quietly = TRUE))
  suppressMessages(install.packages("BiocManager", force = TRUE, repos='http://cran.us.r-project.org', version = '3.18'))
suppressMessages(BiocManager::install("GEOquery", force = TRUE))
library(GEOquery)

######
# Preparing Data
######
dataset <- getGEO(GEO = series,
    GSEMatrix = TRUE,
    AnnotGPL = TRUE,
    destdir = '.'
)

dataset <- dataset[[1]]


saveRDS(dataset, output_file)