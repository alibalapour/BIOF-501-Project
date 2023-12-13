# Troubleshooting

## 1. R packages not installed properly

If there is any problem related to the R BiocManager package or installing packages like GEOquery, limma, Biobase, and M3C, we need to create a conda virtual environment from scratch and install mentioned packages as instructed below.

1. Create a conda environment for R: 

```bash
conda create -n r_env r-essentials r-base
```

2. Activate and get conda environment path by using this: 

```bash
conda activate r_env
echo $CONDA_PREFIX
```

Assume path of environment is `$env_path`.

3. Open R:

```bash
R
```

4. Run below commands inside R terminal:

```r
suppressMessages(install.packages("BiocManager", force = TRUE, repos='http://cran.us.r-project.org', version = '3.18'))
suppressMessages(BiocManager::install("GEOquery", force = TRUE))
suppressMessages(BiocManager::install("limma", force = TRUE))
suppressMessages(BiocManager::install("Biobase", force = TRUE))
suppressMessages(BiocManager::install("M3C", force = TRUE))
```

5. Exit R by running this command inside R: 

```r
exit()
```

6. Inside nextflow pipeline file (`pipeline.nf`), change every `conda "environment.yml"` to `conda “[$env_path]”` . Note that `$env_path` is from step 2.
7. Run the pipeline: 

```bash
nextflow run pipeline.nf
```
