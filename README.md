# nf-core/soma

## Introduction

**nf-core/soma** is a bioinformatics pipeline that detect snp from the input file fastq

<!-- TODO nf-core:
   Complete this sentence with a 2-3 sentence summary of what types of data the pipeline ingests, a brief overview of the
   major pipeline sections and the types of output it produces. You're giving an overview to someone new
   to nf-core here, in 15-20 seconds. For an example, see https://github.com/nf-core/rnaseq/blob/master/README.md#introduction
-->

<!-- TODO nf-core: Include a figure that guides the user through the major workflow steps. Many nf-core
     workflows use the "tube map" design for that. See https://nf-co.re/docs/community/brand/workflow-schematics#examples for examples.   -->
<!-- TODO nf-core: Fill in short bullet-pointed list of the default steps in the pipeline -->
1. Read QC ([`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/))
2. [bwa mem](https://bio-bwa.sourceforge.net/bwa.shtml)
3. [AddOrReplaceReadGroups (Picard)](https://gatk.broadinstitute.org/hc/en-us/articles/35967623740699-AddOrReplaceReadGroups-Picard)
4. [SortSam (Picard)](https://gatk.broadinstitute.org/hc/en-us/articles/35967661254171-SortSam-Picard)
5. [MarkDuplicates (Picard) ](https://gatk.broadinstitute.org/hc/en-us/articles/35967618836635-MarkDuplicates-Picard)
6. [SamFormatConverter (Picard) ](https://gatk.broadinstitute.org/hc/en-us/articles/35967504403611-SamFormatConverter-Picard)
7. [BuildBamIndex (Picard) ](https://gatk.broadinstitute.org/hc/en-us/articles/35967689238939-BuildBamIndex-Picard)
8. [AlignmentSummaryMetrics ](https://gatk.broadinstitute.org/hc/en-us/articles/35967605802651-AlignmentSummaryMetrics)
9. [HsMetrics ](https://gatk.broadinstitute.org/hc/en-us/articles/35967559436443-HsMetrics)
10. [InsertSizeMetrics ](https://gatk.broadinstitute.org/hc/en-us/articles/35967717192731-InsertSizeMetrics)
11. [Mutect2](https://gatk.broadinstitute.org/hc/en-us/articles/35967636854939-Mutect2)
12. [FilterMutectCalls](https://gatk.broadinstitute.org/hc/en-us/articles/35967559772699-FilterMutectCalls)
13. Present QC ([`MultiQC`](http://multiqc.info/))

## Usage

> [!NOTE] 
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/get_started/environment_setup/overview) on how to set-up Nextflow. 

> This pipeline requires specifying some parameters before running for the reference and list of target genes sequenced in the profiles test in nextflow.config file.
```
profiles {
   test {
      params.ref = "/home/trainer07/w3/hg38/hg38_selected"        
      params.reference_fasta = "/home/trainer07/w3/hg38/hg38_selected.fa"
      params.reference_index = "/home/trainer07/w3/hg38/hg38_selected.fa.fai"
      params.reference_dict = "/home/trainer07/w3/hg38/hg38_selected.dict"
      params.intervals = "/home/trainer07/ktrack.mrd165/MRD165.bed"
      params.probe = "/home/trainer07/ktrack.mrd165/Probe.MRD165.interval_list"
      params.interval_list = "/home/trainer07/ktrack.mrd165/MRD165.interval_list"        
   }
```
> Next, create folder for each tool using pixi and copy the path to that folder to replace the path after pixi run --manifest-path in each module.
```
mkdir tool
cd tool
pixi init gatk
cd gatk
pixi project channel add bioconda
pixi add gatk4
pixi add r #only this tool need R for write pdf report from CollectInsertSizeMetrics
```

> Then, prepare a samplesheet with your input data that looks as follows:

`samplesheet.csv`:

```csv
sampleID,fastq1,fastq2
17-MCAABD86_4M,/home/trainer07/17-MCAABD86_4M_R1.fastq.gz,/home/trainer07/17-MCAABD86_4M_R2.fastq.gz
```

Each row represents a pair of fastq files (paired end).

-->

Now, you can run the pipeline using:

<!-- TODO nf-core: update the following command to include all required parameters for a minimal example -->

```bash
nextflow run main.nf \
   -profile test \
   --input samplesheet.csv \
   --outdir <OUTDIR>
```

> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/running/run-pipelines#using-parameter-files).

## Credits

nf-core/soma was originally written by Dung.

We thank the following people for their extensive assistance in the development of this pipeline:

<!-- TODO nf-core: If applicable, make list of people who have also contributed -->

## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](docs/CONTRIBUTING.md).

## Citations

<!-- TODO nf-core: Add citation for pipeline after first release. Uncomment lines below and update Zenodo doi and badge at the top of this file. -->
<!-- If you use nf-core/soma for your analysis, please cite it using the following doi: [10.5281/zenodo.XXXXXX](https://doi.org/10.5281/zenodo.XXXXXX) -->

<!-- TODO nf-core: Add bibliography of tools and data used in your pipeline -->

An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
