#!/bin/bash

#运行之前确认KMeans/input文件夹中有需要的输入文件，以及KMeans/output文件夹没有创建。

#设置最大的k和迭代次数n，从命令行传入
if [ $# -gt 1 ]
then
    k_max=$1
    iternum_max=$2
else
    k_max=2
    iternum_max=2
fi


#开始迭代，从聚2个类开始
for((k=2;k<=$k_max;k++))
do
    for((n=3;n<=$iternum_max;n++))
    do
        hadoop jar KMeansExample-1.0-SNAPSHOT.jar com.hw7.KMeansDriver $k $n KMeans/input KMeans/output
        hdfs dfs -get KMeans/output/clusteredInstances/part-m-00000
        mv part-m-00000 $k"-"$n".csv"
        hdfs dfs -rm -r KMeans/output
    done
done