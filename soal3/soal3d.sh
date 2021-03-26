
#!/bin/bash
Tanggal=$(date +"%m%d%Y")
TANGGAL=$(date +"%d-%m-%Y")
echo $Tanggal

zip -r -m -e -P "$Tanggal" Koleksi.zip ~/Kucing/ ~/Kelinci/ ~/$TANGGAL/

