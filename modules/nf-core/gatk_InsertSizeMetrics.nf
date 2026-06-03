#!/usr/bin/env nextflow

process insertsizemetrics {
    label 'process_low'
    publishDir "result/insert_size_metrics", mode: 'symlink'
    input:
    tuple val(sampleID), path(bam), path("${bam}.bai")

    output: 
    tuple val(sampleID), path("${sampleID}.insert_size_metrics.txt"), path("${sampleID}.insert_size_histogram.pdf"), emit: insertsizemetrics

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk CollectInsertSizeMetrics \
    I=${bam} \
    O=${sampleID}.insert_size_metrics.txt \
    H=${sampleID}.insert_size_histogram.pdf \
    M=0.5
    """
}