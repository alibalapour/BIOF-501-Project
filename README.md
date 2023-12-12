# BIOf 501 Project: Detecting Acute Myeloid Leukemia by using microarray gene expression data

# Background
Leukemia is a group of blood cancers that originate in the bone marrow, affecting the blood and the blood-forming tissues of the body. It is characterized by the abnormal proliferation of immature white blood cells, known as leukemia cells. These cells crowd out normal blood cells, leading to impaired function of the immune system, anemia, and other complications. [[1](https://www.cancer.org/cancer/leukemia.html)]


![](https://www.cancer.gov/sites/g/files/xnrzdm211/files/styles/cgov_panoramic/public/cgov_image/media_image/100/300/6/files/leukemia-aml-cells-article.jpg?h=b1660d00&itok=rY2mJHpW)

Leukemia can be broadly classified into four main types based on the speed of disease progression and the type of white blood cells affected: [[2](https://www.mayoclinic.org/diseases-conditions/leukemia/symptoms-causes/syc-20374373)]

- **Acute lymphocytic leukemia (ALL).** This is the most common type of leukemia in young children.  can also occur in adults.
- **Acute myelogenous leukemia (AML).**  is a common type of leukemia. It occurs in children and adults.  is the most common type of acute leukemia in adults.
- **Chronic lymphocytic leukemia (CLL).** With , the most common chronic adult leukemia, you may feel well for years without needing treatment.
- **Chronic myelogenous leukemia (CML).** This type of leukemia mainly affects adults. A person with  may have few or no symptoms for months or years before entering a phase in which the leukemia cells grow more quickly.
- **Other types.** Other, rarer types of leukemia exist, including hairy cell leukemia, myelodysplastic syndromes and myeloproliferative disorders.

Leukemia arises from genetic mutations in the DNA of blood cells, leading to uncontrolled cell growth. While the exact causes remain elusive, several risk factors have been identified, including:

1. **Genetic Predisposition:** Inherited genetic mutations may increase the risk.
2. **Exposure to Radiation and Chemicals:** High levels of exposure to certain chemicals or ionizing radiation may contribute.
3. **Previous Cancer Treatment:** Certain chemotherapy drugs and radiation therapy used for other cancers may increase the risk. [[3](https://pubmed.ncbi.nlm.nih.gov/29784935/)][[4](https://pubmed.ncbi.nlm.nih.gov/26465987/)]

Leukemia detection involves a combination of clinical assessments, laboratory tests, and advanced diagnostic techniques. Common diagnostic methods include:

1. Physical Exam
2. Blood Tests
3. Bone Marrow Biopsy
4. Imaging Tests
5. Sequencing [[5](https://www.pennmedicine.org/cancer/types-of-cancer/leukemia/diagnosis)][[6](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5569671/)]


In this pipeline, we are using microarray data from samples with and without AML (Acute Myeloid Leukemia) to gain insights related to data and genes that have an effect on this type of cancer. Additionally, the pipeline will generate visualizations and plots for Exploratory Data Analysis.

First, we need to download the data. The selected data is from the [GEO Accession viewer (nih.gov)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE48558). As the data may require preprocessing, we have a dedicated step for this task. Next, the quality of the data is controlled, followed by performing principal component analysis. The pipeline then generates the correlation between samples. Finally, genes with the highest and lowest regulation will be extracted.


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

2. Go to the repository directory:

```bash
cd BIOF-501-Project
```

3. As there is an `enivronment.yml` file in the repository, you don’t need to create a virtual environment. The pipeline itself creates a conda environment and installs required R packages. Run the pipeline by this command:

```bash
nextflow run pipeline.nf
```

### Input data

### Output data


<<<<<<< HEAD
Please read this troubleshooting markdown if you have any problems in running the pipeline:
[a relative link](troubleshooting.md)
=======
# Results


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

## 2. Data is not downloaded properly

>>>>>>> 7c0276bfde4d600673530500ba2b34d68da16d09


# References
