nextflow run main.nf --input hww4/nextflow/git-nf/assets/samplesheet.csv --outdir result -profile singularity
nextflow run main.nf --input /home/trainer07/hww4/nextflow/git-nf/assets/samplesheet.csv --outdir result -profile test -resume

zcat /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/17-MCAABD86_1M.filtered.vcf.gz | zgrep 55191821
zgrep chr7 /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/17-MCAABD86_1M.filtered.vcf.gz | grep 55191821
zgrep chr17 /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/17-MCAABD86_1M.filtered.vcf.gz | grep 7676031
zgrep chr17 /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/82-MCGABL87_4M.filtered.vcf.gz | grep 39724743
zgrep chr17 /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/82-MCGABL87_4M.filtered.vcf.gz | grep 39724728
zgrep chr7 /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/84-MCAABE86_4M.filtered.vcf.gz | grep 55174771
zgrep chr17 /home/trainer07/hww4/nextflow/nf-core-soma_copy/result/filter/84-MCAABE86_4M.filtered.vcf.gz | grep 7675143

# include {multiqc as multiqc_read} from 
# include {multiqc as multiqc_align} from 
# include {multiqc as multiqc_brief} from 
