#!/usr/bin/env nextflow


params.series = 'GSE48558'
params.result_folder = 'Results'
// greeting_ch = Channel.of(params.greeting)



process DOWNLOAD {
    input: 
    val series

//    output:
//    file 'output_table.rds' into data

    script:
    """
    Rscript $PWD/scripts/download.R $series output_table.rds
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
    DOWNLOAD(params.series)
}

