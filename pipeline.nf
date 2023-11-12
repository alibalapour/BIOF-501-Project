#!/usr/bin/env nextflow


params.series = 'GSE48558'
params.result_folder = 'Results'
// greeting_ch = Channel.of(params.greeting)



process DOWNLOAD {
    conda 'reqs.txt'

    input: 
    val series 
    val result_folder

    script:
    """
    mkdir -p "$PWD/$result_folder"
    Rscript $PWD/scripts/download.R $series $PWD/$result_folder/output_table.rds
    """
}

process PREPROCESS {
    input: 
    val result_folder

    script:
    """
    Rscript $PWD/scripts/preprocess.R $PWD/$result_folder/output_table.rds
    """
}

process QUALITY_CONTROL {
    input: 
    val result_folder

    script:
    """
    Rscript $PWD/scripts/quality_control.R $PWD/$result_folder/output_table.rds
    """
}

// process PCA {

// }

// process CORRELATION {
    
// }

// process SIGNIFICANT_DIFFERENCE {

// }

workflow {
    DOWNLOAD(params.series, params.result_folder)
    // PREPROCESS(params.result_folder)
    QUALITY_CONTROL(params.result_folder)
}

