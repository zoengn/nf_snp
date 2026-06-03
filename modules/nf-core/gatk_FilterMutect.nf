#!/usr/bin/env nextflow

process filter_mutect {
    label 'process_low'
    publishDir "result/filter_mutect", mode: 'symlink'

    input: 
    tuple val(sampleID), path("${sampleID}.vcf.gz"), path("${sampleID}.vcf.gz.tbi")
    path ("${sampleID}.vcf.gz.stats")
    path reference_fasta
    path reference_index
    path reference_dict

    output: 
    tuple val(sampleID), path("${sampleID}.filtered.vcf.gz"), emit:filtered_vcf

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk FilterMutectCalls \
    -V ${sampleID}.vcf.gz \
    -O ${sampleID}.filtered.vcf.gz \
    -R ${reference_fasta}
    """
}