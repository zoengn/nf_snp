#!/usr/bin/env nextflow

include { align_metrics } from "../../modules/nf-core/gatk_AlignmentMetrics.nf"
include { hs_metrics } from "../../modules/nf-core/gatk_HsMetrics.nf"
include { insertsizemetrics } from "../../modules/nf-core/gatk_InsertSizeMetrics.nf"

workflow BAM_QC {
    take:
    bam_bai
    reference_fasta
    reference_index
    probe
    interval_list
    
    main:
    align_metrics(
        bam_bai,
        params.reference_fasta
    )

    hs_metrics (
        bam_bai,
        params.reference_fasta,
        params.reference_index,
        params.probe,
        params.interval_list    
    )

    insertsizemetrics (
        bam_bai        
    )
    
    ch_align = align_metrics.out.align_metrics.map { it[1] }
    ch_insertsz = insertsizemetrics.out.insertsizemetrics.map { it -> [it[1], it[2]] }
    ch_hs = hs_metrics.out.hs_metrics.map { it[1] }
    multiqc = ch_align.mix(ch_insertsz).mix(ch_hs).collect()

    emit:
    align_metrics = align_metrics.out.align_metrics
    hs_metrics = hs_metrics.out.hs_metrics
    insertsizemetrics = insertsizemetrics.out.insertsizemetrics
    multiqc = multiqc
}