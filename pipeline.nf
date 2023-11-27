#!/usr/bin/env nextflow
nextflow.enable.dsl=2


params.series = 'GSE48558'
params.result_folder = 'Results'
// greeting_ch = Channel.of(params.greeting)


process DOWNLOAD {
    conda '/home/jupyter-alibalapour93.ab/.conda/envs/r_env'

    input: 
    val series 
    val result_folder
    val _
  
    output:
        val ""

    script:
    """
    mkdir -p "$PWD/$result_folder"
    Rscript $PWD/scripts/download.R $series $PWD/$result_folder/output_table.rds
    """
}

process PREPROCESS {
    conda '/home/jupyter-alibalapour93.ab/.conda/envs/r_env'

    input: 
    val result_folder
    val _

    output:
        val ""


    script:
    """
    Rscript $PWD/scripts/preprocess.R $PWD/$result_folder/output_table.rds $PWD/$result_folder
    """
}

process QUALITY_CONTROL {
    conda '/home/jupyter-alibalapour93.ab/.conda/envs/r_env'

    input: 
    val result_folder
    val _

    output:
        val ""


    script:
    """
    Rscript $PWD/scripts/quality_control.R $PWD/$result_folder/preprocessed_table.rds $PWD/$result_folder
    """
}

process PCA {
    conda '/home/jupyter-alibalapour93.ab/.conda/envs/r_env'

    input: 
    val result_folder
    val _

    output:
        val ""

    script:
    """
    Rscript $PWD/scripts/pca.R $PWD/$result_folder/expr_mat.rds $PWD/$result_folder
    """

}

process CORRELATION {
    conda '/home/jupyter-alibalapour93.ab/.conda/envs/r_env'

    input: 
    val result_folder
    val _

    output:
        val ""

    script:
    """
    Rscript $PWD/scripts/correlation.R $PWD/$result_folder/expr_mat.rds $PWD/$result_folder
    """
}

// process SIGNIFICANT_DIFFERENCE {

// }


workflow {
    next = ""
    // next = DOWNLOAD(params.series, params.result_folder, next)
    next = PREPROCESS(params.result_folder, next)
    next = QUALITY_CONTROL(params.result_folder, next)
    next = PCA(params.result_folder, next)
    next = CORRELATION(params.result_folder, next)
}

