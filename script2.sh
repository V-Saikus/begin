#! /bin/bash
file=/base/phonebook-General
GREEN="\033[32m"
RED="\033[31m"
END="\033[0m"

#while read line 
#do
#if grep -o "$line" mail ;
#then
#continue
#else
#echo "$line" >> mail
#fi
#done <newmail

finder(){
while true;
do
echo -e "$GREEN 1.Mail \n"
echo -e " 2.Phone \n"
echo -e " 3.Surname \n"
echo -e " 4.City \n"
echo -e " 5.Menu $END \n"
read x
case $x in
1)
read name
awk '{print $1 " " $2 " " $5}' /base/phonebook-General | grep -iE " $name"
;;
2)
read name
awk '{print $1 " " $2 " " $4}' /base/phonebook-General | grep -E " $name"
;;
3)
read name
awk '{print $1 " " $2}' /base/phonebook-General | grep -iE " $name"
;;
4)
read name
awk '{print $1 " " $2 " " $6}' /base/phonebook-General | grep -iE " $name"
;;
5)
clear
menu;;
esac
sleep 6
clear
done
}

menu(){
while true ; do
echo -e "$GREEN 1.Statistic \n"
echo -e " 2.Comprasion \n"
echo -e " 3.Mail statistic \n"
echo -e " 4.Find \n"
echo -e " 5.Exit $END \n"
read x
case $x in
1)
while read i;
do
echo -e "$i :"
grep -c "$i" newcity
done < city
;;
2)
echo -e "\n under 19 :"
grep -cEe " [0-9] " -e " 1[0-8] " /base/phonebook-General
echo -e "\n 19-25 :"
grep -cEe " 19 " -e " 2[0-5] " /base/phonebook-General
echo -e "\n after 25 :"
grep -cEe " 2[6-9] " -e " [3-9][0-9] " /base/phonebook-General
;;
3)
echo -e "\n gmail.com :"
grep -ci "@gmail.com " /base/phonebook-General
echo -e "\n mail.ru :"
grep -ci "@mail.ru " /base/phonebook-General
echo -e "\n ukr.net :"
grep -ci "@ukr.net " /base/phonebook-General
;;
4)finder
;;
5) exit 0 ;;
esac
sleep 6
clear
done
}
menu
