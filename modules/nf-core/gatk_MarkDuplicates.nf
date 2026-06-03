#!/usr/bin/env nextflow
process markdup{
    label 'process_low'
    publishDir "result/mark_duplicates", mode: 'symlink'
    input:
    tuple val(sampleID), path(samsorted)
    
    output:
    tuple val(sampleID), path("*.dedup.sam"), emit: sam_dedup
    path("${sampleID}.metrics"), emit: markdup_metrics

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk MarkDuplicates -I ${samsorted} \
    -O ${sampleID}.dedup.sam \
    -M ${sampleID}.metrics \
    --REMOVE_DUPLICATES true \
    --TAGGING_POLICY All
    """

}