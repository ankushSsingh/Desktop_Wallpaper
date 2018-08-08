#!/bin/bash

cd ~/apod
rm *.jpeg *.jpg *.txt index.html
wget https://www.pexels.com/search/HD%20wallpaper/
grep 'img srcset="http' index.html > tmp1.txt
awk -F "\"" '{print $18}' tmp1.txt > tmp2.txt
awk '{split($1,b,/[?]/); print b[1];}' tmp2.txt > tmp3.txt 
N=$(wc -l tmp2.txt)
N=$(echo $N | awk '{print $1}' )
rand=$(shuf -i 1-$N -n 1)
echo $rand > rand.txt
a=$(awk "FNR==$rand" tmp3.txt )
wget $a
imname=$(ls | grep *.jpeg )
/usr/bin/gsettings set org.gnome.desktop.background picture-uri file:///$(pwd)/$imname
