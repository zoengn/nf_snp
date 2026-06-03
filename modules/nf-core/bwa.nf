#!/usr/bin/env nextflow

process run_bwa {
    //directives
    label 'process_low'
    time 1.h
    tag "${sampleID}"
    publishDir "result/bwa", mode: 'symlink'

    input:
    tuple val(sampleID), path(fastq1_clean), path(fastq2_clean)
    val ( hg38_selected ) 

    output:
    tuple val(sampleID), path("${sampleID}.sam"), emit: sam_tuple
    
    script:
    """
    pixi run -m /home/trainer07/hww4/tools/bwa/pixi.toml \
    bwa mem -t 8 \
    -o ${sampleID}.sam \
    ${hg38_selected} \
    ${fastq1_clean} \
    ${fastq2_clean} 

    """
}