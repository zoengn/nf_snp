#!/usr/bin/env nextflow

include { gatk_addRGs } from "../../modules/nf-core/gatk_addRG.nf"
include { sortsam} from "../../modules/nf-core/gatk_SortSam.nf"
include { markdup } from "../../modules/nf-core/gatk_MarkDuplicates.nf"
include { samconvert } from "../../modules/nf-core/gatk_SamConvert.nf"
include { bamindex } from "../../modules/nf-core/gatk_BamIndex.nf"

workflow SAM_EDIT {
    take:
    sam_tuple
    
    main:
    gatk_addRGs(sam_tuple)
    sortsam(gatk_addRGs.out.sam_withRG)
    markdup(sortsam.out.samsorted)
    samconvert(markdup.out.sam_dedup)
    bamindex(samconvert.out.bam)

    multiqc = markdup.out.markdup_metrics.collect()

    emit:
    sam_withRG = gatk_addRGs.out.sam_withRG
    sortsam = sortsam.out.samsorted
    sam_dedup = markdup.out.sam_dedup
    markdup_metrics = markdup.out.markdup_metrics
    bam = samconvert.out.bam
    bam_bai = bamindex.out.bam_bai
    multiqc = multiqc
}