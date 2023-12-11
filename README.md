# BIOf 501 Project: Detecting Acute Myeloid Leukemia (AML) by using microarray gene expression data

# Background

# Usage

## Prerequisites

If you are not running the pipeline on the server provided by the BIOF 501 course instructors, please make sure you have installed below modules and tools:

- R=4.3.0 - [installation guide](https://cran.r-project.org/)
- nextflow - [installation guide](https://www.nextflow.io/docs/latest/getstarted.html) - or use these commands:

```bash
$ curl get.nextflow.io | bash
$ sudo mv nextflow /usr/local/bin
```

- Conda - [installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html)

## Run

1. Clone the repository:

```bash
git clone https://github.com/alibalapour/BIOF-501-Project.git
```

1. Go to the repository directory:

```bash
cd BIOF-501-Project
```

1. As there is an `enivronment.yml` file in the repository, you don’t need to create a virtual environment. The pipeline itself creates a conda environment and installs required R packages. Run the pipeline by this command:

```bash
nextflow run pipeline.nf
```

### Input data

### Output data

## Troubleshooting

### 1. R packages not installed properly

If there is any problem related to the R BiocManager package or installing packages like GEOquery, limma, Biobase, and M3C, we need to create a conda virtual environment from scratch and install mentioned packages as instructed below.

1. Create a conda environment for R: 

```bash
conda create -n r_env r-essentials r-base
```

1. Activate and get conda environment path by using this: 

```bash
conda activate r_env
echo $CONDA_PREFIX
```

Assume path of environment is `$env_path`.

1. Open R:

```bash
R
```

1. Run below commands inside R terminal:

```r
suppressMessages(install.packages("BiocManager", force = TRUE, repos='http://cran.us.r-project.org', version = '3.18'))
suppressMessages(BiocManager::install("GEOquery", force = TRUE))
suppressMessages(BiocManager::install("limma", force = TRUE))
suppressMessages(BiocManager::install("Biobase", force = TRUE))
suppressMessages(BiocManager::install("M3C", force = TRUE))
```

1. Exit R by running this command inside R: 

```r
exit()
```

1. Inside nextflow pipeline file (`pipeline.nf`), change every `conda "environment.yml"` to `conda “[$env_path]”` . Note that `$env_path` is from step 2.
2. Run the pipeline: 

```bash
nextflow run pipeline.nf
```

### 2. Data is not downloaded properly

# Results

# References
