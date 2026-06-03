#!/usr/bin/env nextflow

process mutect2{
    label 'process_low'
    publishDir "result/mutect2", mode: 'symlink'
    input:
    tuple val(sampleID), path(bam), path("${bam}.bai")
    path intervals
    path reference_fasta
    path reference_index
    path reference_dict

    output:
    tuple val(sampleID), path("${sampleID}.vcf.gz"), path("${sampleID}.vcf.gz.tbi"), emit: vcf 
    path("${sampleID}.vcf.gz.stats"), emit: vcf_stat
    
    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/gatk \
    gatk Mutect2 \
    -R ${reference_fasta} \
    -I ${bam} \
    -O ${sampleID}.vcf.gz \
    -L ${intervals}
    """

}