#!/bin/bash

echo -e "\033[1;36mT-NSA-500>\033[0m SYSTEM"
echo "Hostname: $(hostname)"
echo "Manufacturer: $(sudo dmidecode -s system-manufacturer)"
echo "Product name: $(sudo dmidecode -s system-product-name)"
echo "Version: $(sudo dmidecode -s system-version)"
echo "Serial number: $(sudo dmidecode -s system-serial-number)"
echo "Operating system: $(lsb_release -d | cut -f2-)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(arch)"

echo "PRIVATE NETWORK INFORMATION"
ip -br address show

echo "PUBLIC IP ADDR"
curl -s ifconfig.me

echo "DNS"
cat /etc/resolv.conf | grep nameserver

echo "CPU USAGE"
echo "Model name: $(grep 'model name' /proc/cpuinfo | uniq | awk -F ': ' '{print $2}')"
echo "CPU frequency: $(grep 'cpu MHz' /proc/cpuinfo | uniq | awk -F ': ' '{print $2}')"
echo "CPU cores $(grep -c '^processor' /proc/cpuinfo)"

echo "DISK SPACE INFO"
df -h /home | awk 'NR==2 {print "Free space /home: " $4}'
df -h /tmp | awk 'NR==2 {print "Free space /tmp: " $4}'