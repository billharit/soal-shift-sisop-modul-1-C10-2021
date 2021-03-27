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

`export LC_ALL=C` = Mesin membaca titik (.) jadi koma (,)

`-F '\t'` = Memberitahu field seperatornya adalah tab

`BEGIN {max=0}` = Untuk mendeklarasikan variable max

`$1 !~ /^R/` = Mengambil isi pada kolom 1 yaitu Row ID, yang tidak memiliki Row ID dengan awalan R

`{1[$1]=$21/($18-$21)*100` = Mengambil isi pada kolom 1 yang berupa Row ID, kemudian akan dihitung Percentage Profit setiap ID nya

`if(max <= i[$1]) {max = i[$1]; mid = $1}` = Mencari Percentage Profit paling besar, hasilnya disimpan di variabel max dan ID nya di variabel mid

`END {print mid,"dengan presentase",max"%."}` = Output nya berupa ID dengan persentase terbesar dan Percentage Profitnya

`Laporan-TokoShiSop.tsv` = Nama file yang menjadi input

b. Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan **daftar nama customer pada transaksi tahun 2017 di Albuquerque**.

``` 
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain : "
awk -F '\t' '$2 ~ /^CA-2017/ {if($10 == "Alburquerque") print $7}
' Laporan-TokoShiSop.tsv | sort -u
```
**Penjelasan :**

`-F '\t'` = Memberitahu field seperatornya adalah tab

`$2 ~ /^CA-2017/` = Mengambil isi pada kolom 2 yaitu Order ID, yang memiliki Order ID dengan awalan CA-2017

`{if($10 == "Alburquerque")`  = Mengambil isi pada kolom 10 berdasarkan city "Albuquerque"

`print $7}` = Output nya berupa nama customer

`Laporan-TokoShiSop.tsv` = Nama file yang menjadi input

`sort -u` = Untuk sort dan remove data yang duplikat

c. TokoShiSop berfokus tiga segment customer, antara lain: *Home Office, Customer, dan Corporate*. Clemong ingin meningkatkan penjualan pada segmen customer yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment customer** dan **jumlah transaksinya yang paling sedikit**.

``` 
printf "Tipe segmen customer yang penjualannya paling sedikit adalah "
awk -F '\t' '
BEGIN {i["Costumer"]=0; i["Corporate"]=0; i["Home Office"]=0}
$8 !~ /Segment/ {i[$8]++}
END {for(x in i) print x,"dengan",i[x],"transaksi."}
' Laporan-TokoShiSop.tsv | sort -k3 -n | head -1
```
**Penjelasan :**

`-F '\t'` = Memberitahu field seperatornya adalah tab

`BEGIN {i["Costumer"]=0; i["Corporate"]=0; i["Home Office"]=0}` = Untuk mendeklarasikan array i

`$8 !~ /Segment/` = Mengambil isi pada kolom 8 yaitu Segment, yang tidak bernama Segment

`{i[$8]++}` = Menghitung banyak segmen

`END {for(x in i) print x,"dengan",i[x],"transaksi."}` = Outputnya berupa nama segmen dan banyaknya

`Laporan-TokoShiSop.tsv` = Nama file yang menjadi input

`sort -k3 -n` = Sort pada kolom ke 3 yaitu banyak segmen dan diurutkan dari terkecil ke besar

`head -1` = Mengambil 1 data teratas yang sudah diurutkan

d. TokoShiSop membagi wilayah bagian (region) penjualan menjadi empat bagian, antara lain: *Central, East, South, dan West*. Manis ingin mencari **wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah tersebut**.
```
printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah "
awk -F '\t' '
$13 !~ /Region/ {i[$13]+=$21}
END {(for x in i) print x,"dengan total keuntungan",i[x]}
' Laporan-TokoShiSop.tsv | sort -k5 -n | head -1
```
**Penjelasan :**

`-F '\t'` = memberitahu field seperatornya adalah tab

`$13 !~ /Region/` = Mengambil isi pada kolom 13 yaitu Region, yang tidak bernama Region

`{i[$13]+=$21}` = Mengambil isi pada kolom 13 berupa Region, lalu dihitung jumlah profit per Regionnya

`END {(for x in i) print x,"dengan total keuntungan",i[x]}` = Outputnya merupakan nama Region dan jumlah profitnya

`Laporan-TokoShiSop.tsv` = Nama file yang menjadi input

`sort -k5 -n` = Sort pada kolom ke 5 yaitu jumlah profit yang didapat dan diurutkan dari terkecil hingga besar

`head -1` = Mengambil 1 data teratas yang sudah diurutkan

Agar mudah dibaca oleh Manis, Clemong, dan Steven, (e) kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:

```
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```
Hasil dari script soal2_generate_laporan_ihir_shisop.sh akan dituliskan di hasil.txt dengan

`bash soal2_generate_laporan_ihir_shisop.sh > hasil.txt`

Hasil dapat dilihat di [hasil](soal2/hasil.txt)

### Soal 3

