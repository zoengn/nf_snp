#!/usr/bin/env nextflow

include { run_fastp } from "../../modules/nf-core/FASTP.nf"
include { run_bwa } from "../../modules/nf-core/bwa.nf"

workflow FASTP_to_BWA {
    take:
    reads_ch
    ref
    
    main:
    run_fastp(reads_ch)
    multiqc = run_fastp.out.fastp_report.collect()

    // Call variants from the indexed BAM file
    run_bwa(
        run_fastp.out.reads_clean,
        params.ref
    )
    emit:
    fastp_report = run_fastp.out.fastp_report
    reads_clean = run_fastp.out.reads_clean
    sam_tuple = run_bwa.out.sam_tuple
    multiqc = multiqc
}