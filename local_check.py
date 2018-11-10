#!/usr/bin/python
import os
import subprocess

ip_range=256
get_pi_ips="arp -na | grep b8:27:eb | cut -d ' ' -f2 | sed 's/) (//;s/[()]//g'"
ip_prefix='172.19.248.'

for i in range (1,ip_range):
    address=ip_prefix+str(i)
    print address
    os.system("ping -c 1 " + address)
print'loop complete'

pi_ip = sys.stdout.read(get_pi_ips)

print "raspberry pi ip is" + str(pi_ip)
