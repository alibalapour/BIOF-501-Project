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

// process PREPROCESS {

// }

// process QUALITY_CONTROL {

// }

// process PCA {

// }

// process CORRELATION {
    
// }

// process SIGNIFICANT_DIFFERENCE {

// }

workflow {
    DOWNLOAD(params.series, params.result_folder)
}

