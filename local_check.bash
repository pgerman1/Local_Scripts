#!/bin/bash
pi_mac_base=b8:27:eb
retro_mac=b8:27:eb:21:04:53
zero_mac=b8:27:eb:68:33:48

ip_range=255 # number of IP addresses to ping
get_pi_ips="arp -na | grep b8:27:eb | cut -d ' ' -f2 | sed 's/) (//;s/[()]//g'"

ip_prefix=$(ifconfig | grep wlp2s0 -A1 | grep inet | cut -c14-24)
myip=$(ifconfig | grep wlp2s0 -A1 | grep inet | cut -c14-27)

#pi_ip = sys.stdout.read(get_pi_ips)

#print "raspberry pi ip is" + str(pi_ip)

function main() {
    echo "your IP Address is $myip"
    echo "checking $ip_prefix 1-255....."
    ping_search
#    get_pi_addr
}

function ping_search(){
printf "searching...|"
for i in $(seq 1 $ip_range);
do
    address="$ip_prefix$i"
    printf "==$i" 
    ping -c 1 $address > /dev/null
done
#    os.system("ping -c 1 " + address)
printf "|\n Search Complete \n"
}

function get_pi_addr(){

numfound=$(arp -na | grep $pi_mac_base | wc -l)

if [ $numfound -gt 0 ] 
then
    printf "Found $numfound Pis!\n"
    retro_ip=$(arp -na | grep $retro_mac | cut -d ' ' -f2 | sed 's/) (//;s/[()]//g')
    echo 'the retro pi IP is:' $retro_ip
    echo  $retro_ip > $HOME/.retro_ip

    zero_ip=$(arp -na | grep $zero_mac | cut -d ' ' -f2 | sed 's/) (//;s/[()]//g')
    echo 'the pi zero IP is:' $zero_ip
    echo  $zero_ip > $HOME/.zero_ip
else
    echo 'No Rasberry Pis found on WLAN'
fi

}

main

