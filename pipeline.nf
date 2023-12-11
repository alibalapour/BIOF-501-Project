#!/usr/bin/env nextflow
nextflow.enable.dsl=2


params.series = 'GSE48558'
params.result_folder = 'Results'

process DOWNLOAD {
    conda 'environment.yml'

    input: 
    val series 
    val result_folder
    val _
  
    output:
        val("${PWD}/${result_folder}/output_table.rds"), emit: output_rds

    script:
    """
    mkdir -p "$PWD/$result_folder"
    Rscript $PWD/scripts/download.R $series $PWD/$result_folder/output_table.rds
    """
}

process PREPROCESS {
    conda 'environment.yml'

    input: 
    val result_folder
    val output_rds

    output:
        val("${PWD}/${result_folder}/preprocessed_table.rds"), emit: preprocessed_table_rds
        val("${PWD}/${result_folder}/grouped_samples.rds"), emit: grouped_samples_rds

    script:
    """
    Rscript $PWD/scripts/preprocess.R $output_rds $PWD/$result_folder
    """
}

process QUALITY_CONTROL {
    conda 'environment.yml'

    input: 
    val result_folder
    val preprocessed_dataset_path

    output:
        val("${PWD}/${result_folder}/expr_mat.rds"), emit: expr_mat_rds

    script:
    """
    Rscript $PWD/scripts/quality_control.R $preprocessed_dataset_path $PWD/$result_folder
    """
}

process PCA {
    conda 'environment.yml'

    input: 
    val result_folder
    val expr_mat_path
    val grouped_sample_path

    output:
        val(""), emit: pca_output

    script:
    """
    Rscript $PWD/scripts/pca.R $expr_mat_path $grouped_sample_path $PWD/$result_folder
    """

}

process CORRELATION {
    conda 'environment.yml'

    input: 
    val result_folder
    val expr_mat_path
    val grouped_sample_path

    output:
        val ""

    script:
    """
    Rscript $PWD/scripts/correlation.R $expr_mat_path $grouped_sample_path $PWD/$result_folder
    """
}

process SIGNIFICANT_DIFFERENCE {
    conda 'environment.yml'

    input: 
    val result_folder
    val preprocessed_dataset_path
    val expr_mat_path
    val grouped_sample_path

    output:
        val ""

    script:
    """
    Rscript $PWD/scripts/significant_difference.R $preprocessed_dataset_path $expr_mat_path $grouped_sample_path $PWD/$result_folder
    """
}


workflow {
    next = ""
    dataset_path = DOWNLOAD(params.series, params.result_folder, next)
    (preprocessed_dataset_path, grouped_sample_path) = PREPROCESS(params.result_folder, dataset_path)
    expr_mat_path = QUALITY_CONTROL(params.result_folder, preprocessed_dataset_path)
    PCA(params.result_folder, expr_mat_path, grouped_sample_path)
    CORRELATION(params.result_folder, expr_mat_path, grouped_sample_path)
    SIGNIFICANT_DIFFERENCE(params.result_folder, preprocessed_dataset_path, expr_mat_path, grouped_sample_path)
}

