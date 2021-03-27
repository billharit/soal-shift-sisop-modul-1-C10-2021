#!/bin/bash

# SOAL 2A
echo " "

printf "Transaksi terakhir dengan profit percentage terbesar yaitu "
export LC_ALL=C

awk -F '\t' '
BEGIN {max=0} 
{ i[$1]=$21 / ($18 - $21) * 100 
if(max <= i[$1]) {max=i[$1]; mid=$1}} 
END {print mid,"dengan presentase",max"%."} 
' Laporan-TokoShiSop.tsv 

# SOAL 2B

echo " "

echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain :"
awk -F '\t' '$2 ~ /^CA-2017/ {if($10 == "Albuquerque") print $7}
' Laporan-TokoShiSop.tsv | sort -u

# SOAL 2C

echo " "

printf "Tipe segmen customer yang penjualannya paling sedikit adalah "
awk -F '\t' '
BEGIN {i["Consumer"]=0; i["Corporate"]=0; i["Home Office"]=0}
$8 !~ /Segment/ {i[$8]++}
END {for(x in i) print x,"dengan",i[x],"transaksi."}
' Laporan-TokoShiSop.tsv | sort -k3 -n | head -1

# SOAL 2D

echo " "

printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " 
awk -F '\t' '
$13 !~ /Region/ {i[$13]+=$21}
END {for(x in i) print x" dengan total keuntungan "i[x]} 
' Laporan-TokoShiSop.tsv | sort -k5 -n | head -1
