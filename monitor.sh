:> monitor.txt
date >> monitor.txt
IPLIST="ip.txt"

for i in $(cat $IPLIST)
do

CURRENT=$(ssh -oStrictHostKeyChecking=no root@$i df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=90
if [ "$CURRENT" -gt "$THRESHOLD" ]
then
echo -e '\n' >> monitor.txt
echo "IP : $i" >> monitor.txt
HOSTNAME=`ssh -oStrictHostKeyChecking=no root@$i hostname`
echo "Server : " $HOSTNAME >> monitor.txt
echo "DISK USAGE :" >> monitor.txt
ssh -oStrictHostKeyChecking=no root@$i df -H | grep -vE '^Filesystem|boot|udev|tmpfs|cdrom|loop*' | awk '{ print $1 "  " $5 " " $6 }' >> monitor.txt
echo " ------------------------------ " >> monitor.txt
echo -e '\n' >> monitor.txt

fi

CPUCURRENT=$(ssh -oStrictHostKeyChecking=no root@$i top -n 1 -b | awk '/^%Cpu/{print $2}' | cut -f 1 -d ".")
CPUTHRESHOLD=50
if [[ "$CPUCURRENT" -gt "$CPUTHRESHOLD" ]]
then
echo "IP : $i" >> monitor.txt
HOSTNAME=`ssh -oStrictHostKeyChecking=no root@$i hostname`
echo "Server : " $HOSTNAME >> monitor.txt
echo "CPU USAGE : "$CPUCURRENT"%" >> monitor.txt
echo " ------------------------------ " >> monitor.txt
fi

RAMCURRENT=$(ssh -oStrictHostKeyChecking=no root@$i free -t | awk 'NR == 2 {printf $3/$2*100}' | cut -f 1 -d ".")
RAMTHRESHOLD=50
if [[ "$RAMCURRENT" -gt "$RAMTHRESHOLD" ]]
then
echo "IP : $i" >> monitor.txt
HOSTNAME=`ssh -oStrictHostKeyChecking=no root@$i hostname`
echo "Server : " $HOSTNAME >> monitor.txt
echo "RAM USAGE : "$RAMCURRENT"%" >> monitor.txt
echo " ------------------------------ " >> monitor.txt
fi

INODECURRENT=$(ssh -oStrictHostKeyChecking=no root@$i df -i / | grep / | awk '{ print $5}' | sed 's/%//g')
if [[ "$INODECURRENT" -gt "$THRESHOLD" ]]
then
echo "IP : $i" >> monitor.txt
HOSTNAME=`ssh -oStrictHostKeyChecking=no root@$i hostname`
echo "Server : " $HOSTNAME >> monitor.txt
echo "INODE USAGE : "$INODECURRENT"%" >> monitor.txt
echo " ------------------------------ " >> monitor.txt
fi
done
echo -e '\n' >> monitor.txt
echo " --------- Monitoring Completed --------- " >> monitor.txt
