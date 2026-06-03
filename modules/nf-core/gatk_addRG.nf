#!/usr/bin/env nextflow

process gatk_addRGs {
    label 'process_low'
    publishDir "result/samaddRG", mode: 'symlink'

    input:
    tuple val(sampleID), path(sam)

    output:
    tuple val(sampleID), path("*.withRG.sam"), emit: sam_withRG

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk AddOrReplaceReadGroups \
    I=${sam} \
    O=${sampleID}.withRG.sam \
    RGID=1 \
    RGLB=lib1 \
    RGPL=ILLUMINA \
    RGPU=unit1 \
    RGSM=${sampleID}
    """
}