#!bin/bash
rm -rf failed.txt

for every_ip in `cat ip.txt`;
#for every_ip in "10.30.30.200";
do
   #ping -q -c 1 -t 2 "$every_ip"
   ping -q -c 1 -t 2 "$every_ip" 2>&1 > /dev/null
   retping=$?
   retnc=`nc -z -w 3 "$every_ip" 3389 &> /dev/null && echo "Online" || echo "Offline"`
   #nc -z "$every_ip" 3389
   #retnc=$?
   #echo $retping
   #echo $retnc
   #set -x
   if [ "$retping" -ne "0"  ] || [ "$retnc" != "Online"  ]
   #if [ $retping -ne 0  ]
   then
   #set +x
    echo "=================== ping failed for $every_ip ==============="
    echo $every_ip >> failed.txt
    #var=$((var + 1))
   fi
   #set +x
done
#echo $var
cat failed.txt
