#!/usr/bin/env nextflow

process multiqc {
    label 'process_low'
    publishDir "result/multiqc", mode: 'symlink'
    input:
    path(report_files)

    output:
    tuple path("multiqc_report.html"), path("multiqc_data"), emit: multiqc

    script:
    """
    pixi run --manifest-path /home/trainer07/hww4/tools/multiqc \
    multiqc .
    """
}