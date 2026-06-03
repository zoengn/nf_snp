#!/usr/bin/env nextflow

process hs_metrics {
    label 'process_low'
    publishDir "result/hs_metrics", mode: 'symlink'
    input:
    tuple val(sampleID), path(bam), path("${bam}.bai")
    path reference_fasta
    path reference_index
    path probe
    path interval_list

    output:
    tuple val(sampleID), path("${sampleID}.hs_metrics.txt"), emit: hs_metrics

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk CollectHsMetrics \
    I=${bam} \
    O=${sampleID}.hs_metrics.txt \
    R=${reference_fasta}\
    BAIT_INTERVALS=${probe}\
    TARGET_INTERVALS=${interval_list}
    """
}
