#!bin/bash

for every_ip in `cat plain.txt`;
#for every_ip in "10.30.30.200";
do
    ping "$every_ip" -q -c 1 -t 2
    retping=$?
    nc -z "$every_ip" 3389
    retnc=$?
        echo $retping
        echo $retnc
   if [ $retping -ne 0  ] || [ $retnc -ne 0  ]
   then
    echo "=================== ping failed ==============="
        echo $every_ip >> failed.txt
        var=$((var + 1))
   fi
done
echo $var
cat failed.txt
