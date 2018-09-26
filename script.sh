#! /bin/bash

RED="\033[31m"
GREEN="\033[32m"
END="\033[0m"

menuGeneral(){
while true; do
echo -e "1)Current user \n"
echo -e "2)Current data \n"
echo -e "3)Current time \n"
echo -e "4)Space homedir \n"
echo -e "5)Another menu \n"
echo -e "6)Exit \n"
read x
sleep 1
clear
case $x in
	1)
echo -e "$GREEN Current user: $RED $USER $END \n"
	;;
	2)
echo -e "$GREEN Current data: $RED `date +"%Y-%m-%d"` $END \n"
	;;
	3)
echo -e "$GREEN Current time: $RED `date | awk '{print$4}'` $END \n"
	;;
	4)
echo -e "$GREEN Space homedir:$RED `df -h $HOME` $END \n"
	;;
	5) menu2 ;;

	6) exit 0 ;;

	*) echo "error";;
esac
sleep 4
clear
done
}

menu2(){
while true;do
echo -e "1)IP \n"
echo -e "2)Security \n"
echo -e "3)Active users \n"
echo -e "4)Uptime user \n"
echo -e "5)Other menu \n"
read x
sleep 1
clear
case $x in
	1)
echo -e "$GREEN IP:$RED `grep "IPADDR" /etc/sysconfig/network-scripts/ifcfg-enp0s3 | grep -Eo "[0-9|.]+"` $END \n"
	;;

	2)
echo -e "$GREEN Security:$RED `tail -10 /var/log/messages` $END \n"
	sleep 5
	;;

	3)
echo -e "$GREEN Active users: $RED `w` $END \n"
	;;

	4)
echo -e "$GREEN Uptime:$RED `uptime -p` $END \n"
	;;

	5) menuGeneral ;;

	*) echo "error";;
esac
sleep 4
clear
done
}
menuGeneral
