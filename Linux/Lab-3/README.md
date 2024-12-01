# confgiure BIND9 as a DNS solutiont 
- BIND9 : an open source implementation of DNS, available for almost all Linux distributions. BIND stands Berkeley Internet Name Domain & it allows us to publish DNS information on internet as well as allows us to resolve DNS queries for the users. BIND is by far the most used DNS software on Internet.

 we need to create two VMs in the same network one act as the server and the other one act as Client to test the configurtion 

# Server side 
- install bind9 
```
$ sudo apt update
$ sudo apt install -y bind9 bind9utils bind9-doc dnsutils
```
After the packgae have installed successfully move to the next part to edit the configurtion files which located in /etc/bind.
- The most important confugrtion file is /etc/bind/named.conf.options
1. Allow recursive query
2. Forwarders (DNS query will be forwarded to the forwarders when your local DNS server is unable to resolve query)
it should look like that
```
options {
    directory "/var/cache/bind";
    allow-query { any; };
    recursion yes;
    forwarders {
        8.8.8.8;  forwoard the dns query if the local dns can't resolve it to 8.8.8.8 
    };
};
```
`- create the zone file at /etc/bind/zones/<choose_name> 
- add the path into /etc/bind/zone/named.conf.local
```
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";
zone "ivolve.local" {
    type master;
    file "/etc/bind/zones/<file_name>";
};
```
add this confgurtion to the file u have created *zone_file* edit it based on ur confgrution 
replace 192.168.1.12
```
;
; BIND data file for ivolve.local
;
$TTL    604800
@       IN      SOA     ivolve.local. admin.ivolve.local. (
                          2024113001 ; Serial
                          604800     ; Refresh
                          86400      ; Retry
                          2419200    ; Expire
                          604800 )   ; Negative Cache TTL

; Name servers
@       IN      NS      ns1.ivolve.local.
ns1     IN      A       192.168.1.12

; A record for ivolve.local
ivolve.local.   IN      A       192.168.1.12

; Subdomains
www     IN      A       192.168.1.12
test    IN      A       192.168.1.12

```
