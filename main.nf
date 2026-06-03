#!/usr/bin/env nextflow
include { FASTP_to_BWA } from "./subworkflows/local/fastp_to_bwa.nf"
include { SAM_EDIT } from "./subworkflows/local/sam_edit.nf"
include { BAM_QC } from "./subworkflows/local/bam_qc.nf"
include { SNP } from "./subworkflows/local/snp.nf"
include { multiqc } from "./modules/nf-core/multiqc.nf"

workflow {
    main:
    reads_ch = channel.fromPath(params.input)
    .splitCsv(header: true)
    .map { row -> tuple(row.sampleID, file(row.fastq1), file(row.fastq2))
    }

    FASTP_to_BWA(reads_ch, params.ref)
    SAM_EDIT(FASTP_to_BWA.out.sam_tuple)
    BAM_QC(
        SAM_EDIT.out.bam_bai, 
        params.reference_fasta, 
        params.reference_index, 
        params.probe, 
        params.interval_list)
    
    SNP(
        SAM_EDIT.out.bam_bai, 
        params.intervals, 
        params.reference_fasta, 
        params.reference_index, 
        params.reference_dict
    )

    ch_multiqc = Channel.empty() 
    ch_multiqc = FASTP_to_BWA.out.multiqc
        .mix(SAM_EDIT.out.multiqc)
        .mix(BAM_QC.out.multiqc)
        .mix(SNP.out.multiqc)
        .collect()
    multiqc(ch_multiqc)
}
