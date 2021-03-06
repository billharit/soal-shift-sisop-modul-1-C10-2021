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

Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan daftar peringkat pesan error terbanyak yang dibuat oleh ticky dan laporan penggunaan user pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

(a) Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: 

`Raw_Data='syslog.log'` = mendeklarasikan file syslog.log dengan nama variabel "Raw_Data"

jenis log (ERROR/INFO) :

`jenis_log=$(grep -oP "(INFO|ERROR)" "$Raw_Data")` = menggunakan regular expression untuk mengetahui kata "INFO" atau "ERROR" tiap line pada data mentah

![gambar hasil Error/Info](https://drive.google.com/uc?export=view&id=1c-KGl3dm3uDOyuZ6LpkjR5bhZt9H_XBt)

pesan log :

`pesan_log=$(grep -oP "(?<=[INFO|ERROR] ).*(?<=\ )" "$Raw_Data")` = menggunakan positive lookbehind untuk mengambil token setelah "INFO" atau "ERROR", mengambil token selain line break.

![gambar hasil pesan log](https://drive.google.com/uc?export=view&id=11LFNzst6NnyArR6ILLNxi8wiVrlV-tnh)

username  :

`user_log=$(grep -oP "(?<=\().*(?=\))" "$Raw_Data")` = menggunakan positive lookbehind untuk mengambil token diantara tanda "(" dan ")".

![gambar hasil username](https://drive.google.com/uc?export=view&id=1ndH-14dsdUGr80CRzaC1bqcFxZB2-xNX)

(b) Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

`error_message=$(grep -oP "(?<=ERROR ).*(?<=\ )" "$Raw_Data" | sort | uniq -c| sort -nr)` = code tersebut berfungsi untuk menyimpan semua pesan error beserta jumlah kemunculannya dan diurutkan secara descending. `"(?<=ERROR ).*(?<=\ )"` menggunakan positive lookbehind untuk mengambil pesan setelah kata "ERROR". ` sort | uniq -c| sort -nr` digunakan untuk mengurutkan pesan error unik secara numerik--banyaknya muncul--dari frekuensi muncul tertinggi ke terendah.

![gambar hasil pesan error dan frekuensi](https://drive.google.com/uc?export=view&id=1p7Pe3gMHLGOHx-GgsEDETWYmL9eR3eAx)

(c) Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

`error_seluruh_user=$(grep -oP "(?<=ERROR ).*(?<=\))" "$Raw_Data")` = menyimpan pesan error seluruh user menggunakan positive lookbehind.

![gambar pesan error tiap user](https://drive.google.com/uc?export=view&id=1YLOa8qmOD249DfutTer63E8mPRL1OKsB)

`info_seluruh_user=$(grep -oP "(?<=INFO ).*(?<=\))" "$Raw_Data")` = menyimpan pesan info seluruh user menggunakan positive lookbehind.

![gambar pesan info tiap user](https://drive.google.com/uc?export=view&id=13vlnurhVu_q-8VzZDGHcY03X3NYQ7NE0)

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

(d) Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
Contoh:
```bash
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

`echo "ERROR,COUNT" > "error_message.csv"
grep -oP "(?<=ERROR ).*(?<=\ )" "$Raw_Data" | sort | uniq -c | sort -nr | while read count pesan_log;
do
        printf "%s,%d\n" "$pesan_log" "$count" >> "error_message.csv"
done`

**Penjelasan:**
`echo "ERROR,COUNT" > "error_message.csv"` = memasukkan header "ERROR,COUNT" sekaligus membuat file "error_message.csv"

`grep -oP "(?<=ERROR ).*(?<=\ )" "$Raw_Data" | sort | uniq -c | sort -nr | while read count pesan_log;
do
        printf "%s,%d\n" "$pesan_log" "$count" >> "error_message.csv"
done` = mengambil pesan error dari data mentah, lalu diurutkan berdasarkan banyaknya muncul secara descending. Lalu lakukan looping dan memasukkan pesan serta banyaknya muncul pesan error kedalam "error_message.csv"

![hasil 1d](https://drive.google.com/uc?export=view&id=1wWSpYt3ZCTUFUWBIzYd7VxEzs59jDl26)

(e) Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.
Contoh:
```bash
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```
`echo "Username,INFO,ERROR" > "user_statistic.csv"
grep -oP "(?<=\().*(?=\))" "$Raw_Data" | sort | uniq | while read user;
do
    info_tiap_user=$(grep "$user" <<< "$info_seluruh_user" | wc -l);
    error_tiap_user=$(grep "$user" <<< "$error_seluruh_user" | wc -l);
    printf "%s,%d,%d\n" "$user" "$info_tiap_user" "$error_tiap_user" >> "user_statistic.csv"
done`

**Penjelasan:**

`echo "Username,INFO,ERROR" > "user_statistic.csv"` = memasukkan header "Username,INFO,ERROR" sekaligus membuat file "user_statistic.csv"

`grep -oP "(?<=\().*(?=\))" "$Raw_Data" | sort | uniq | while read user;` = mengambil nama user (unik) dari data mentah dan dilakukan looping selama masih ada user.

`info_tiap_user=$(grep "$user" <<< "$info_seluruh_user" | wc -l);` = mengambil jumlah info yang dimiliki user ke-n.

 `error_tiap_user=$(grep "$user" <<< "$error_seluruh_user" | wc -l);` = mengambil jumlah error yang dimiliki user ke-n.

`printf "%s,%d,%d\n" "$user" "$info_tiap_user" "$error_tiap_user" >> "user_statistic.csv"` = mencetak username, jumlah info, dan jumlah error user ke-n kedalam file "user_statistic.csv"

![hasil 1e](https://drive.google.com/uc?export=view&id=1xnbF-N0rmLoQsMfo3I6OGfgwdA8pusj9)

**Kendala Nomor 1:**
Kendala nomor 1 adalah ketika ingin mencari syntax regular expression untuk mendapatkan hasil yang diinginkan. Untuk mengatas i kendala tersebut, dilakukan pencarian daring salah satunya via regexr.com.

### Soal 2
---
> Source Code
> **[hasil.txt](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal2/hasil.txt)** ,
> **[soal2_generate_laporan_ihir_shisop.sh](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal2/soal2_generate_laporan_ihir_shisop.sh)** 

Steven dan Manis mendirikan sebuah startup bernama ???TokoShiSop???. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan ???Laporan-TokoShiSop.tsv???.

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
awk -F '\t' '$2 ~ /2017/ {if($10 == "Alburquerque") print $7}
' Laporan-TokoShiSop.tsv | sort -u
```
**Penjelasan :**

`-F '\t'` = Memberitahu field seperatornya adalah tab

`$2 ~ /2017/` = Mengambil isi pada kolom 2 yaitu Order ID, yang memiliki Order ID pada tahun 2017

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
END {for(x in i) print x,"dengan total keuntungan",i[x]}
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

Agar mudah dibaca oleh Manis, Clemong, dan Steven, (e) kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file ???hasil.txt??? yang memiliki format sebagai berikut:

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

<details>
  <summary>Gambar Hasil</summary>

![hasil](https://github.com/billharit/soal-shift-sisop-modul-1-C10-2021/blob/main/soal2/hasil.png)
</details>

**Kendala :**
Pada file Laporan-TokoShiSop.tsv untuk angka menggunakan titik (.) jadi butuh LC_ALL=C agar mesin bisa baca jadi koma (,)


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
<details>
  <summary>Gambar Soal3a</summary>

![Screenshot from 2021-04-04 18-40-39](https://user-images.githubusercontent.com/77628684/113508245-13c21500-9579-11eb-9e8d-1dabddae7cdd.png)
</details>

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
<details>
  <summary>Gambar Soal3b</summary>
	
![Screenshot from 2021-04-04 18-59-47](https://user-images.githubusercontent.com/77628684/113508330-964ad480-9579-11eb-9c14-c0b72762acbf.png)
</details>

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
<details>
  <summary>Gambar Soal3c</summary>
	
![Screenshot from 2021-04-04 19-00-13](https://user-images.githubusercontent.com/77628684/113508338-a5ca1d80-9579-11eb-90a3-060763a0af19.png)

![Screenshot from 2021-04-04 19-00-29](https://user-images.githubusercontent.com/77628684/113508340-acf12b80-9579-11eb-9aef-63ed19f03566.png)
</details>

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
<details>
  <summary>Gambar Soal3d</summary>
	
![Screenshot from 2021-04-04 19-00-39](https://user-images.githubusercontent.com/77628684/113508346-b5e1fd00-9579-11eb-8353-8c15ef9aad63.png)
</details>

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

<details>
  <summary>Gambar Soal3e</summary>
	
![Screenshot from 2021-04-04 19-01-12](https://user-images.githubusercontent.com/77628684/113508420-1a04c100-957a-11eb-8d43-9bca0b616302.png)

![messageImage_1617537752316](https://user-images.githubusercontent.com/77628684/113508438-3acd1680-957a-11eb-9506-f310e25dd840.jpg)

</details>

**Penjelasan**
* `0 7 * * 1-5 bash soal3d.sh` setiap jam 7 hari senin-jum'at (tepatnya saat masuk kuliah) dijalankan script soal3d.sh untuk menzip
* `0 18 * * 1-5 unzip`setiap jam 18 hari senin-jum'at (tepatnya saat kuliah selesai) dijalankan perintah unzip dengan tambahan berikut
* `-P $(date +"%m%d%Y")` membuka password secara otomatis sesuai tanggal zip dibuat
* `-o ~/Koleksi.zip` zip yang ingin diunzip
* `&&` agar perintah setelahnya tidak tereksekusi jika perintah sebelumnya gagal
* `rm ~/Koleksi.zip` untuk mendelete zip nya

**Problem**
* Linux bug program yang dijalankan dirun berhasil tetapi tidak muncul file
* Bukti dari berhasil adalah jika menggunakan -j maka file bisa diekstrak ke direktori root sedangkan untuk masuk ke foldernya sendiri di terminal sudah terlihat terextract tapi folder tidak terbuat
