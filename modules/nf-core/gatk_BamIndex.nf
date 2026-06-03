#!/usr/bin/env nextflow

process bamindex {
    label 'process_low'
    publishDir "result/bamindex", mode: 'symlink'

    input:
    tuple val(sampleID), path(bam)

    output: 
    tuple val(sampleID), path(bam), path("*.bai"), emit: bam_bai

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk BuildBamIndex I=${bam}
    """
}