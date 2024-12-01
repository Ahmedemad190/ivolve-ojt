# confgiure BIND9 as a DNS solutiont 
- BIND9 : an open source implementation of DNS, available for almost all Linux distributions. BIND stands Berkeley Internet Name Domain & it allows us to publish DNS information on internet as well as allows us to resolve DNS queries for the users. BIND is by far the most used DNS software on Internet.

 we need to create two VMs in the same network one act as the server and the other one act as Client to test the configurtion 

# server side 
- install bind9 
```
$ sudo apt update
$ sudo apt install -y bind9 bind9utils bind9-doc dnsutils
```
