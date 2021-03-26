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

