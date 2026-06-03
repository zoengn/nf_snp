#!/usr/bin/env nextflow

process sortsam {
    label "process_low"
    publishDir "result/sortsam", mode: 'symlink'
    input:
    tuple val(sampleID), path(sam_withRG)

    output:
    tuple val(sampleID), path("*.with_RG.sorted.sam"), emit: samsorted

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk SortSam \
    I=${sam_withRG} \
    O=${sampleID}.with_RG.sorted.sam \
    SORT_ORDER=coordinate
    """
}