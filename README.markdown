##Overview
[![Build Status](https://travis-ci.org/Yelp/puppet-netstdlib.png)](https://travis-ci.org/Yelp/puppet-netstdlib)

`netstdlib` is a collection of puppet functions and facts for network related work.

##Functions

cidr_to_broadcast
-------------------
Converts an CIDR address of the form 192.168.0.1/24 into its broadcast address

cidr_to_netmask
-------------------
Converts an CIDR address of the form 192.168.0.1/24 into its netmask address

cidr_to_network
-------------------
Converts an CIDR address of the form 192.168.0.1/24 into its network address

fqdn_mac
-------------------
Generate MAC addresses based on the results of fqdn_rand. Useful for VMs that 
might have the same hostname.

gethostbyaddr2array
-------------------
Resolve an IP address into one or more names. (Looks up reverse DNS PTRs)

gethostbyname2array
-------------------
Resolve a name into one or more IP addresses.

int_to_ip
-------------------
Converts an IP in its 32 bit integer representation to a dotted address of the form 192.168.0.1

ip_in_cidr
-------------------
Checks if an ip address is contained within a CIDR address of the form 192.168.0.1/24

ip_to_int
-------------------
Converts a dotted address of the form 192.168.0.1 into its 32 bit integer representation

netmask_to_masklen
-------------------
Converts a netmask of the form 255.255.0.0 to the mask length (e.g. 16)

##Limitations

Puppet functions are server-side, facts are client side. Keep this in mind as 
any DNS related functions will take place on the server.

