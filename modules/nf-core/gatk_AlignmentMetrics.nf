#!/usr/bin/env nextflow

process align_metrics {
    label 'process_low'
    publishDir "result/align_metrics", mode: 'symlink'
    input: 
    tuple val(sampleID), path(bam), path("*.bai")
    path reference_fasta

    output:
    tuple val(sampleID), path("${sampleID}_alignmentsummary.txt"), emit: align_metrics

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk CollectAlignmentSummaryMetrics \
    R=${reference_fasta}\
    I=${bam}\
    O=${sampleID}_alignmentsummary.txt
    """
}