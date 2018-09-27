#! /bin/bash
#^
url="https://postcode.in.ua/ua/codes/city/1007/a"

#curl $url | grep -i "text_tab_1"| grep -oE "https://postcode.in.ua/ua/codes/city/1007/street/[0-9]+" > adresses
count=0
p=.png
png="`ls /root/reps/begin/`"
for line in $png;
do
#echo -E "$line"
#wget -P /root/reps/begin/images_script4/ `
#curl $line | grep -oE "https://postcode.in.ua/images/image_c.php\?id=[0-9]+" >> adressespng

count=$((count+1))

mv /root/reps/begin/images_script4/"$line" images_script4/"IMG$count$p"
done




