#!/usr/bin/env nextflow

params.series = ''
params.result_folder = 'Results'
// greeting_ch = Channel.of(params.greeting)



process DOWNLOAD {
    input: 
    path series

    output
}

process PREPROCESS {

}

process QUALITY_CONTROL {

}

process PCA {

}

process CORRELATION {
    
}

process SIGNIFICANT_DIFFERENCE {

}

workflow {
    letters_ch = SPLITLETTERS(greeting_ch)
    results_ch = CONVERTTOUPPER(letters_ch.flatten())
    results_ch.view{ it }
}

