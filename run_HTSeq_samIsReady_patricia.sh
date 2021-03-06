if [ $# -lt 3 ]
then
echo "[1] - dir with bams"
echo "[2] - dir with analysis"
echo "[3] file with samples"
echo "[4] -gtf, e.g. /u/home/s/serghei/project/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf ; ~/scratch/Mus_musculus/Ensembl/NCBIM37/Annotation/Genes/genes.gtf"
exit 1
fi

dir=$2
mkdir $dir
cd $dir
gtf=$4

while read sample
do
mkdir $sample
cd $sample

echo "#!/bin/bash">run_${sample}.sh
echo ". /u/local/Modules/default/init/modules.sh" >>run_${sample}.sh
echo "module load samtools" >>run_${sample}.sh
echo "module load python" >>run_${sample}.sh
#echo "samtools sort -n ${1}/${sample}.bam ${1}/${sample}_sort_byname">>run_${sample}.sh

#echo "samtools view -h ${1}/${sample}_sort_byname.bam >${sample}_sort_byname.sam">>run_${sample}.sh



#echo "head -n 30 ${sample}_sort_byname.sam | tail -n 1 " >>run_${sample}.sh


#echo " sort -k 1,1 ${2}/mapped_${sample}.sam >mapped_${sample}_sort.sam">>run_${sample}.sh

echo " 	~/anaconda/bin/python /u/home/s/serghei/project/code/import/HTSeq-0.6.1/scripts/htseq-count --idattr=ID --stranded=no  ${1}/${sample}.sam $gtf >${sample}.counts" >>run_${sample}.sh


#echo "python ~/project/code/import/HTSeq-0.6.1/scripts/htseq-count -r pos -m intersection-strict mapped_${sample}_sort.sam ~/scratch/Mus_musculus/Ensembl/NCBIM37/Annotation/Genes/genes.gtf >mapped_${sample}.counts">>run_${sample}.sh
cd ..
done<$3
