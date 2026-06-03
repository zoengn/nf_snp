#!/usr/bin/env nextflow

process run_fastp {
    label 'process_single'
    tag "${sampleID}"
    publishDir "result/fastp", mode: 'symlink'

    input:
    tuple ( val(sampleID), path(fastq1), path(fastq2) )

    output:
    tuple val(sampleID),
      path("*_R1.clean.fastq.gz"),
      path("*_R2.clean.fastq.gz"),
      emit: reads_clean
    tuple path("${sampleID}.html"), path("${sampleID}.json"), emit: fastp_report

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/fastp \
    fastp -q 30 -i ${fastq1} \
    -I ${fastq2} \
    -o ${sampleID}_R1.clean.fastq.gz \
    -O ${sampleID}_R2.clean.fastq.gz \
    -h ${sampleID}.html \
    -j ${sampleID}.json \
    --thread 8
    """
}
