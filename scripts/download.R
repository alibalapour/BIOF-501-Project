if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

suppressMessages(BiocManager::install("GEOquery"))
suppressMessages(BiocManager::install("limma"))
suppressMessages(BiocManager::install("Biobase"))
suppressMessages(BiocManager::install("M3C"))
suppressMessages(install.packages(c("pheatmap", "reshape2", "plyr", "ggplot2", "stringr", "ggfortify")))

# Setting workingDirectory to project's directory 
curD <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(sub(paste0("/", sub("(.+)/","",curD)),"",curD))

######
# Preparing Data
######
series <- 'GSE48558'
dataset <- getGEO(GEO = series,
    GSEMatrix = TRUE,
    AnnotGPL = TRUE,
    destdir = '.'
)

dataset <- dataset[[1]]