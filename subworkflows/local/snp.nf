#!/usr/bin/env nextflow

include { mutect2 } from "/home/trainer07/hww4/nextflow/nf-core-soma_copy/modules/nf-core/gatk_Mutect2.nf"
include { filter_mutect } from "/home/trainer07/hww4/nextflow/nf-core-soma_copy/modules/nf-core/gatk_FilterMutect.nf"

workflow SNP {
    take:
    bam_bai
    intervals
    reference_fasta
    reference_index
    reference_dict
    
    main:
    mutect2(
        bam_bai,
        params.intervals,
        params.reference_fasta,
        params.reference_index,
        params.reference_dict
    )
    
    filter_mutect(
        mutect2.out.vcf,
        mutect2.out.vcf_stat,
        params.reference_fasta,
        params.reference_index,
        params.reference_dict
    )
    multiqc = mutect2.out.vcf_stat

    emit:
    vcf = mutect2.out.vcf
    vcf_stat = mutect2.out.vcf_stat
    filtered_vcf = filter_mutect.out.filtered_vcf
    multiqc = multiqc
}