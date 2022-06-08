# monitor
This a simple shell tool for monitoring your linux servers cpu,memory,disk etc consumption.The script allows you to identify the servers that exceeded the usage threshold. It is a free linux monitoring tool.

With this script, we do not have to check each server individually. We run it on a centralised server where we can get access to other servers like ssh servers.Note that the script connect the servers or systems via ssh passwordless method.So you must enable this ssh feature.

Before you execute
------------------
-> Add the server's IP in ip.txt
-> Give execute permission(chmod u+x monitor.sh).

The result will stored in monitor.txt file.
