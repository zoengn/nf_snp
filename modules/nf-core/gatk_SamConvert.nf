#!/usr/bin/env nextflow

process samconvert{
    label 'process_low'
    publishDir "result/samconvert", mode: 'symlink'
    input:
    tuple val(sampleID), path(sam_dedup)

    output:
    tuple val(sampleID), path("*.bam"), emit: bam


    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk SamFormatConverter \
    I=${sam_dedup} \
    O=${sampleID}.bam
    """
}