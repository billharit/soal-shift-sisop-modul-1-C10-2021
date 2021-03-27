# soal-shift-sisop-modul-1-C10-2021

### KELOMPOK : C10

| **No** | **Nama** | **NRP** | 
| ------------- | ------------- | --------- |
| 1 | Dicksen Alfersius Novian  | 05111940000076 | 
| 2 | Vyra Fania Adelina  | 05111940000109 |
| 3 | Bill Harit Yafi  | 05111940000114 |

## Soal Shift Modul 1 Sisop
### Soal 1
---
> Source Code
> **[soal1.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal1/soal1.sh)** 

### Soal 2
---
> Source Code
> **[hasil.txt](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal2/hasil.txt)** ,
> **[soal2_generate_laporan_ihir_shisop.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh)** 

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

`END {for(x in i) print x,"dengan total keuntungan",i[x]}` = Outputnya merupakan nama Region dan jumlah profitnya

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
---
> Source Code
> **[soal3a.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal3/soal3a.sh)** ,
> **[soal3b.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal3/soal3b.sh)** ,
> **[soal3c.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal3/soal3c.sh)** ,
> **[soal3d.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal3/soal3d.sh)** ,
> **[cron3b.tab](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal3/cron3b.tab)** ,
> **[crond3e.tab](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal3/cron3e.tab)**

Pada soal ini dibagi menjadi 5 sub-tugas 


**3a. kita disuruh untuk mengunduh 23 gambar dari website yang diberi dan juga menyimpan file lognya. dalam pengunduhan kita juga diharuskan untuk tidak mendapatkan file duplikat dan juga dalam penamaan tidak boleh ada angka yang diskip.**

```
#!/bin/bash

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

done
```
**Penjelasan** 
* Untuk mendapatkan gambar 23 kali kita menggunakan wget (-a untuk log, -O untuk penamaan file) yang dilakukan dalam looping dari num (1) sampai limit (23).
* dalam soal dilarang untuk mengunduh duplikat maka dari itu kita menggunakan md5sum untuk mengechek gambar-gambar
* line berikut digunakan untuk mendapatkan string md5sum dari file gambar dan menyimpannya dalam array check agar bisa di compare pada line berikutnya

```
## Buat Nama untuk String Compare
check[$num]="$(md5sum Koleksi_$i | awk '{print $1;}')"
```
```
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

```
* dengan mengcompare string md5sum dari file $num ke $j (contohnya jika file ke 4 maka terminal akan mengcomparenya dengan 3,2,1) jika file yang dicompare memiliki string md5sum yang sama maka file koleksi bernomorkan $i akan di delete. 
* karena kita tidak diminta untuk mencari pengganti file yang sudah dihapus. $num dan $limit di decrement dengan maksud agar penamaan file berikutnya berurutan dengan sebelumnya 
dan yang kita download berkurang satu

**3b. soal 3b meminta untuk membuat crontab serta gambar yang didownload diletakkan di folder tertentu. diminta dalam soal untuk menjalankan file pada jam 20.00 ditanggal tertentu yaitu pada setiap 7 hari mulai dari tanggal 1 dan setiap 4 hari mulai dari tanggal 2. untuk folder diminta dinamakan tanggal DD-MM-YY pada hari-h script dijalankan**
```
!/bin/bash

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

mv Koleksi_$i /home/struk/$TANGGAL/Koleksi_$i

done

mv Foto.log /home/struk/$TANGGAL/Foto.log
```
**Penjelasan**
* Hampir sama dengan 3a hanya saja ditambah dengan cron tab dan pemindahan folder
* di akhir setiap for loop diberi line `mv Koleksi_$i /home/struk/$TANGGAL/Koleksi_$i` untuk memindahkan file Koleksi nomor $i ke dalam folder yang bernama $TANGGAL
* setelah for loop selesai terdapat line `mv Foto.log /home/struk/$TANGGAL/Foto.log` untuk memindahkan log ke dalam folder $TANGGAL

```
# crontab 
0 20 1/7 * * bash ~/soal3b.sh
0 20 2/4 * * bash ~/soal3b.sh
```
* `0 20 1/7 * * bash ~/soal3b.sh` berarti menjalankan script soal3b setiap jam 20.00 setiap tujuh hari lewat mulai dari tanggal 1
* `0 20 2/4 * * bash ~/soal3b.sh` berarti menjalankan script soal3b setiap jam 20.00 setiap empat hari lewat mulai dari tanggal 2 

**3c. diminta untuk mengunduh gambar kelinci dan kucing secara zigzag (bebas mulai darimana) serta memisahkan folder gambar kelinci dan kucing**
```
#!/bin/bash

mkdir ~/Kucing
mkdir ~/Kelinci

hari=$(date +"%--j")

oddcheck=$(( $hari % 2 ))

if [ $oddcheck -eq 0 ]
then
	wget https://loremflickr.com/320/240/kitten -O "Kucing-$hari" 
	mv Kucing-$hari ~/Kucing
elif [ $oddcheck -ne 0 ]
then
	wget https://loremflickr.com/320/240/bunny -O "Kelinci-$hari"
	mv Kelinci-$hari ~/Kelinci
fi
```
**Penjelasan**
* `mkdir ~/Kucing` Membuat direktori Kucing
* `mkdir ~/Kelinci` Membuat direktori Kelinci
* `hari=$(date +"%--j")` kita membuat angka hari untuk penanda foto didownnload kapan digunakan %--j yang berarti tanggal dari 1 sampai 365, menggunakan -- agar tidak terdapat angka seperti 001,020 (angka yang depannya nol dihilangkan agar bisa masuk ke dalam algoritma berikutnya)
* untuk membuat script mendownload secara zigzag kita menggunakan ganjil genap yang mengcompare hari dari tahun yang sudah kita dapat sebelumnya
* file dinamakan Objek-$hari untuk menandakan tanggal didownload dan agar tidak terjadi overwrite

**3d. soal meminta untuk memindahkan semua folder foto kucing dan kelinci kedalam zip dengan password tanggal mmddyyyy**
```
#!/bin/bash
Tanggal=$(date +"%m%d%Y")
TANGGAL=$(date +"%d-%m-%Y")
echo $Tanggal

zip -r -m -e -P "$Tanggal" Koleksi.zip ~/Kucing/ ~/Kelinci/ ~/$TANGGAL/
```
Penjelasan
* $Tanggal untuk membuat password
* $TANGGAL untuk mencari nama folder
* dengan menggunakan `zip -r -m -e -P "$Tanggal" Koleksi.zip ~/Kucing/ ~/Kelinci/ ~/$TANGGAL/ `
* `-r` berarti secara rekursi masuk kedalam folder sesuai tempatnya
* `-m` untuk mendelete file setelah di zip
* `-e` untuk memberi password pada zip 
* `-P "$Tanggal"` untuk memberi input password sesuai format (jika hanya -e aja maka terminal akan meminta input password secara manual)
* `Koleksi.zip` nama file zip
* `~/Kucing/ ~/Kelinci/ ~/$TANGGAL/ ` direktory dan isi yang ingin di zip 

**3e. soal meminta untuk secara pola menzip saat kuliah berlangsung dan unzip saat tidak kuliah**
```
0 7 * * 1-5 bash soal3d.sh
0 18 * * 1-5 unzip -P $(date +"%m%d%Y") -o ~/Koleksi.zip && rm ~/Koleksi.zip
```
**Penjelasan**
* `0 7 * * 1-5 bash soal3d.sh` setiap jam 7 hari senin-jum'at (tepatnya saat masuk kuliah) dijalankan script soal3d.sh untuk menzip
* `0 18 * * 1-5 unzip`setiap jam 18 hari senin-jum'at (tepatnya saat kuliah selesai) dijalankan perintah unzip dengan tambahan berikut
* `-P $(date +"%m%d%Y")` membuka password secara otomatis sesuai tanggal zip dibuat
* `-o ~/Koleksi.zip` zip yang ingin diunzip
* `&&` agar perintah setelahnya tidak tereksekusi jika perintah sebelumnya gagal
* `rm ~/Koleksi.zip` untuk mendelete zip nya
