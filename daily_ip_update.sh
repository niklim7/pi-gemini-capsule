#!/bin/bash
# Dynamic DNS Updater for DuckDNS

# SECRETS
DOMAIN="your-domain-here"
TOKEN="insert-your-duckdns-token-here"  <-- Change this!

echo url="https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip=" | curl -k -o ~/duckdns/duck.log -K -
