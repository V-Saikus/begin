#! /bin/bash

url="https://app.bitpool.com"
var=`curl $url | grep -i "bpoappversion" | grep -oE "[0-9]+"`
hm=$[`date +%H`+`date +%M`]
echo -E "`date "+TIME:%H:%M:%S"`"
if (( "$hm"=="$var" )) ;
then
echo -E "$hm = $var"
elif (( "$hm">"$var" )) ;
then
echo -E "$hm > $var"
elif (( "$hm"<"$var" )) ;
then
echo -E "$hm > $var"
else 
echo "ERROR"
fi

