#! /bin/bash
file=/base/phonebook-General
GREEN="\033[32m"
RED="\033[31m"
END="\033[0m"
count=0

createUser(){
while true;
do
clear
echo -e "$GREEN 1.Custom \n"
echo -e " 2.Default (recommended for starters) \n"
echo -e " 3.Back $END \n"
read x1
case $x1 in
1)
echo -e " Name: \n"
read name
if grep "^$name:" /etc/passwd >> /dev/null ;
then 
echo -e " already exist \n"
sleep 4
clear 
createUser 
fi

while [ "$count"==0 ] ; do
echo -e " UID: \n"
read uid
if grep ":x:$uid:" /etc/passwd >> /dev/null ; then 
echo -e " already exist \n" 
sleep 2
clear 
createUser
else
$count=1
fi
done
$count=0

while [ "$count"==0 ] ; do
echo -e " GID: \n"
read gid
if grep ":x:[0-9]+:$gid:" /etc/passwd >> /dev/null ; then 
echo -e " already exist \n" 
sleep 2
clear 
else
$count=1
fi
done
$count=0

while [ "$count"==0 ] ; do
echo -e " Expire: \n"
read expire
if echo "$expire" | grep "[0-9]+{4}-[0-9]+{2}-[0-9]+{2}" >> /dev/null ; then 
echo -e " unexpected \n"
sleep 2
clear
else
$count=1
fi
done
$count=0

echo -e " comment: \n"
read comment
groupadd -g $gid $name
useradd -u $uid -g $gid -e $expire -c $comment $name
;;
2)
echo -e " Name: \n"
read name
if grep "^$name:" /etc/passwd >> /dev/null ;
then 
echo -e " already exist \n"
sleep 2
clear
createUser
fi
useradd $name
;;
3)
clear
user
;;
esac
sleep 2
clear
done
}

modUser(){
echo -e "$RED Name: $END \n"
read name
if grep "^$name:" /etc/passwd > /dev/null ; then
while true ; do
echo -e "$RED 1.Name \n"
echo -e " 2.UID \n"
echo -e " 3.GID \n"
echo -e " 4.Expire \n"
echo -e " 5.Comment $END \n"
read x2
case $x2 in
1)
echo " Changed name: "
read nameC
if grep "^$nameC:" /etc/passwd > /dev/null ;
then 
echo -e " already exist \n"
else
usermod -l $nameC $name
sleep 2
user
fi
;;
2)
echo " Changed UID: "
read uid
if cut -d: -f1 /etc/passwd | grep -E "$uid" >> /dev/null ; then
echo -e " already exist \n"
else
usermod -u $uid $name
sleep 2
user 
fi
;;
3)
echo " Changed GID: "
read gid
if grep ":x:[0-9]+:$gid:" /etc/passwd >> /dev/null ; then 
echo -e " already exist \n"
else
usermod -g $gid $name
sleep 2
user
fi
;;
4)
echo " Expiry: "
read expire
if echo -e "$expire" | grep "[0-9]+{4}-[0-9]+{2}-[0-9]+{2}" >> /dev/null ; then
echo -e " unexpected \n"
else
usermod -e $expire $name
sleep 2
user 
fi
;;
5)
echo " Comment: "
read comment
usermod -c $comment $user
sleep 2
user
;;
esac
done
else
clear
echo "$name not found \n"
sleep 2
fi
}

show(){
echo -e "$GREEN 1.Users \n"
echo -e " 2.Groups $END \n"
read x3
case $x3 in
1)
cat /etc/passwd
;;
2)
cat /etc/group
;;
esac
sleep 4
menu
}

user(){
while true;
do
clear
echo -e "$GREEN 1.Create \n"
echo -e " 2.Mod \n"
echo -e " 3.Delete \n"
echo -e " 4.Back $END \n"
read x
case $x in
1)createUser
;;
2)modUser
;;
3)
echo -e " Name: \n"
read name
userdel -rf $name
;;
4)
clear
menu;;
esac
sleep 2
clear
done
}

createGroup(){
while true;
do
clear
echo -e "$GREEN 1.Custom \n"
echo -e " 2.Default \n"
echo -e " 3.Back $END \n"
read x4
case $x4 in
1)
echo " Name: "
read name
if grep "^$name:" /etc/group > /dev/null ; then
echo -e " alredy exist \n"
group
fi
echo " GID: "
read gid
if grep "$gid" /etc/group > /dev/null ; then
echo -e " alredy exist \n"
group
else
groupadd -g $gid $name
fi
;;
2)
echo " Name: "
read name
if grep "^$name:" /etc/group > /dev/null ; then
echo -e " alredy exist \n"
else
groupadd $name
fi
;;
3)group
;;
esac
sleep 2
clear
done
}

modGroup(){
echo -e "$RED Name: $END \n"
read name
if grep "^$name:" /etc/group > /dev/null ; then
while true;
do
clear
echo -e "$GREEN 1.Name \n"
echo -e " 2.GID \n"
echo -e " 3.Back $END \n"
read x5
case $x5 in
1)
echo " Name: "
read nameC
if grep "^$nameC:" /etc/group > /dev/null ; then
echo -e " alredy exist \n"
else
groupmod -n $nameC $name
group
fi
;;
2)
echo " GID: "
read gid
if grep "$gid" /etc/group > /dev/null ; then
echo -e " alredy exist \n"
else
groupmod -g $gid $name
group
fi
;;
3)group
;;
esac
sleep 2
clear
done
else
echo -e " Not found \n"
sleep 2
fi
}

group(){
while true;
do
clear
echo -e "$GREEN 1.Create \n"
echo -e " 2.Mod \n"
echo -e " 3.Delete \n"
echo -e " 4.Back $END \n"
read x4
case $x4 in
1)createGroup
;;
2)modGroup
;;
3)
echo -e " Name: \n"
read name
groupdel $name
;;
4)
clear
menu;;
esac
sleep 2
clear
done
}

menu(){
while true ; do
clear
echo -e "$GREEN 1.User \n"
echo -e " 2.Group \n"
echo -e " 3.Show \n"
echo -e " 4.Exit $END \n"
read x
case $x in
1)user
;;
2)group
;;
3)show
;;
4) exit 0 ;;
esac
sleep 4
clear
done
}
menu
