#!/bin/bash

## Bikin Folder tanggal
TANGGAL=$(date +"%d-%m-%Y")
mkdir -p $TANGGAL

## Bikin Array Buat Check
check=( $(for x in {1..23};do echo "0";done) )

## Bikin Total Permintaan diunduh berpakali
limit=23

## Masuk Looping
for ((num=1;num<=limit; num=num+1))
do
j=num
## Untuk Penamaan File 1 -> 01
i=$(printf "%02d" $num) 
## Mengunduh File
wget -a Foto.log https://loremflickr.com/320/240/kitten -O "Koleksi_$i"

## Buat Nama untuk String Compare
check[$num]="$(md5sum Koleksi_$i | awk '{print $1;}')"



## String Compare 
for ((j=num-1;j>=1;j=j-1))
        do
        if [[ "${check[$num]}" == "${check[$j]}" ]];
        then
                rm Koleksi_$i
                limit=$((limit-1))
                num=$((num-1))
        fi
        done

mv Koleksi_$i /home/struk/$(date +"%d-%m-%Y")/Koleksi_$i

done


