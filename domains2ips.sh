#!/bin/bash
if [ -z "$1" ]; then
  echo "Use: ./domains2ips.sh [domainsfile]"
  exit 1
fi
while read d || [[ -n $d ]]; do
  ip=$(dig +short $d|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1)
  if [ -n "$ip" ]; then
    echo "$d ; $ip"
    echo $ip >> domains.tmp
  else
    echo "$d => Fail resolving"
  fi
done < $1
sort domains.tmp | uniq > domains.new
echo -e "\nGrouping IPs:"
cat domains.new
rm domains.tmp
rm domains.new
