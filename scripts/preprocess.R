suppressMessages(library("Biobase"))
suppressMessages(library("limma"))

# Access command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check the number of arguments
if (length(args) < 1) {
    stop("Usage: Rscript preprocess.R <dataset_path>")
}

# Extract arguments
dataset_path <- args[1]

# Read saved dataset
dataset <- readRDS(dataset_path)
dataset = dataset[[1]]

# Selecting Normal and Leukemia from dataset
dataset <- dataset[, which(dataset$`phenotype:ch1` == 'Normal' | dataset$`phenotype:ch1` == 'Leukemia')]

# Function for grouping samples
getGroup <- function(a){
  if(dataset$`phenotype:ch1`[a] == "Normal"){
    source_name = strsplit2(dataset$source_name_ch1[a], "\\+")[1, 1]
    return(paste0("normal_", source_name))  # we need source_name in the following
  }
  else{
    return('test')
  }
}

# Get group of each sample
groupedSamples <- sapply(1:length(dataset$`phenotype:ch1`), getGroup)

saveRDS(dataset, '../done.rds')