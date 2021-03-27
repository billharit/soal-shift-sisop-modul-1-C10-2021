# soal-shift-sisop-modul-1-C10-2021

### KELOMPOK : C10

Anggota :
1. Dicksen Alfersius Novian - 05111940000076
2. Vyra Fania Adelina - 05111940000109
3. Bill Harit Yafi - 05111940000114

## Soal Shift Modul 1 Sisop
### Soal 1

### Soal 2
Steven dan Manis mendirikan sebuah startup bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “Laporan-TokoShiSop.tsv”.

a. Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui **Row ID** dan **Profit Percentage** terbesar (jika hasil profit percentage terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari profit percentage, yaitu: **`Profit Percentage = (Profit - Cost Price) * 100`** Cost Price didapatkan dari pengurangan Sales dengan Profit. (**Quantity diabaikan**).

```
printf "Transaksi terakhir dengan profit percentage terbesar yaitu "
export LC_ALL=C

awk -F '\t' '
BEGIN {max=0}
$1 !~ /^R/ {i[$1]=$21/($18-$21)*100
if(max <= i[$1]) {max = i[$1]; mid = $1}}
END {print mid,"dengan presentase",max"%."}
' Laporan-TokoShiSop.tsv
```
**Penjelasan :** 


b. Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan **daftar nama customer pada transaksi tahun 2017 di Albuquerque**.

``` 
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain : "
awk -F '\t' '$2 ~ /^CA-2017/ {if($10 == "Alburquerque") print $7}
' Laporan-TokoShiSop.tsv | sort -u
```
**Penjelasan :**

c. TokoShiSop berfokus tiga segment customer, antara lain: *Home Office, Customer, dan Corporate*. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment customer** dan **jumlah transaksinya yang paling sedikit**.

``` 
printf "Tipe segmen customer yang penjualannya paling sedikit adalah "
awk -F '\t' '
BEGIN {i["Costumer"]=0; i["Corporate"]=0; i["Home Office"]=0}
$8 !~ /Segment/ {i[$8]++}
END {for(x in i) print x,"dengan",i[x],"transaksi."}
' Laporan-TokoShiSop.tsv | sort -nr | head -1
```
**Penjelasan :**

d. TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: *Central, East, South, dan West*. Manis ingin mencari **wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah tersebut**.
```
printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah "
awk -F '\t' '
$13 !~ /Region/ {i[$13]+=$21}
END {(for x in i) print x,"dengan total keuntungan",i[x]}
' Laporan-TokoShiSop.tsv | sort -k5 -n | head -1
```
**Penjelasan :**

### Soal 3

