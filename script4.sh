#! /bin/bash
#^
url="https://postcode.in.ua/ua/codes/city/1007/a"

curl $url | grep -i "text_tab_1"| grep -oE "https://postcode.in.ua/ua/codes/city/1007/street/[0-9]+" > adresses

while read line
do
curl $line | grep -oE "https://postcode.in.ua/images/image_c.php\?id=[0-9]+" >> adressespng
done < adresses

while read line
do
wget -P /root/reps/begin/images_script4/ "$line"
done < adressespng

count=0
p=.png
png="`ls /root/reps/begin/images_script4`"
for line in $png;
do
count=$((count+1))

mv /root/reps/begin/images_script4/"$line" images_script4/"IMG$count$p"
done




