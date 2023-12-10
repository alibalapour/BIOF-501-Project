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


# if (!require("BiocManager", quietly = TRUE))
#   suppressMessages(install.packages("BiocManager", force = TRUE, repos='http://cran.us.r-project.org', version = '3.18'))
# suppressMessages(install.packages("BiocManager", force = TRUE, repos='http://cran.us.r-project.org', version = '3.18'))
# suppressMessages(BiocManager::install("GEOquery", force = TRUE))
# suppressMessages(BiocManager::install("limma", force = TRUE))
# suppressMessages(BiocManager::install("Biobase", force = TRUE))
# suppressMessages(BiocManager::install("M3C", force = TRUE))

# # # Installing libraries
# suppressMessages(install.packages(c("pheatmap", "reshape2", "plyr", "ggplot2", "stringr", "ggfortify"), repos = "http://cran.us.r-project.org"))


# # Setting workingDirectory to project's directory 
# curD <- dirname(rstudioapi::getActiveDocumentContext()$path)
# setwd(sub(paste0("/", sub("(.+)/","",curD)),"",curD))


######
# Import packages
######
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