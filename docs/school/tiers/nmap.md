# **Nmap (Network mapper)**

## **Introduction**
<span class="red-command">"Enumeration is the key"</span>  
The default scan setting of nmap is a TCP-SYN scan (-sS). (scan speed ~ thousand ports/second). 
The TCP-SYN scan sends one packet with the SYN flag and, therefore, never completes the three-way handshake, which results in not establishing a full TCP connection to the scanned port.

Packet flow for a TCP-SYN scan:  
1. nmap sends a TCP packet with a SYN flag to a port under scanning.  
2. If the target sends a TCP packet with a ACK flag back to the port => <span class="red-command">open</span>  
3. If the target sends a TCP packet with a RST flag back to the port => <span class="red-command">closed</span>  
3. If the target drops the incoming packets => <span class="red-command">filtered</span> and a strong firewall is in place.

### <span class="red-command">Handy Flags</span>
Lets remember some of the most common flags passed to nmap.  

| Flag                                              | Description                          |
|-------------------            |--------------------------------------|
| <span class="command">-sS</span>                  | Default nmap scan, TCP-SYN |
| <span class="command">-sT</span>                  | TCP Connect scan (stealthy for port scanning) |
| <span class="command">-n</span>                   | Disable DNS resolution |
| <span class="command">-Pn</span>                  | Disable ICMP Echo requests |
| <span class="command">-PE</span>                  | Enable ICMP Echo requests (Useful in host discovery) |
| <span class="command">-sn</span>                  | Disable port scanning (Useful in host discovery) |
| <span class="command">-p 21</span>                | Scan port 21 |
| <span class="command">-p-</span>                  | Scan all ports |
| <span class="command">-p 21-30</span>             | Scan port 21 to 30 |
| <span class="command">-p 21,30</span>             | Scan port 21 AND 30 |
| <span class="command">--disable-arp-ping</span>   | Disable ARP Ping |
| <span class="command">--packet-trace</span>       | Trace the request and response packets |
| <span class="command">-sV</span>                  | Version scan |
| <span class="command">-oA</span>                  | Output in all formats |

## **Discovering Hosts**
Before we scan a single host for open ports and its services, we first have to determine if it is alive or not.
For discovering hosts, we need to explicitly disable port scanning through <span class="command">-sn</span> flag. If port scanning is disabled then by default ICMP Echo Requests are sent to the host.  
If the host is alive it will send an ICMP reply.

```
sudo nmap 10.10.14.24 -sn -oA host
```

### <span class="red-command">Packet trace</span>
<span class="command">-PE</span> - Performs the ping scan by using 'ICMP Echo requests' against the target.  
<span class="command">--packet-trace</span> - Tells nmap to trace the request and response packets. 
```
sudo nmap 10.10.14.24 -sn -oA host -PE --packet-trace
```

### <span class="red-command">Disable ARP requests</span>
<span class="command">--disable-arp-ping</span> - Disables ARP requests and scan our target with the desired ICMP echo requests

```
sudo nmap 10.10.14.24 -sn -PE --disable-arp-ping -oA nmap/icmpscan
```

ICMP echo request can help us determine if our target is alive and identify its system.

## **Hosts and Port Scanning**
### <span class="red-command">Discovering open TCP ports</span>
<span class="command">-p 80, 445</span> - only scans port 80 and 445.  
<span class="command">--top-ports=10</span> -  top ports from the Nmap database that have been signed as most frequent.  
<span class="command">-p 80-443</span> - scan all the ports lying in range 80 to 443.  
<span class="command">-F</span> - perform a fast scan by only scanning top 100 ports.  
<span class="command">-p-</span> - scan all the ports.  

### <span class="red-command">Packet Analysis</span>
Let's scan port 443 via TCP-SYN scan.
<span class="command">-Pn</span> - Disable the ICMP Echo requests.
<span class="command">-n</span> - Disable DNS resolution.  
<span class="command">--packet-trace</span> - Trace the packets.  
<span class="command">--disable-arp-ping</span> - Disables ARP requests.  

```
sudo nmap 10.10.14.24 -p 443 --packet-trace -Pn -n --disable-arp-ping
```

### <span class="red-command">TCP Connect Scan</span>
The scan sends an SYN packet to the target port and waits for a response. It is considered open if the target port responds with an SYN-ACK packet and closed if it responds with an RST packet.  
The Connect scan is useful because it is the most accurate way to determine the state of a port, and it is also the most stealthy.  

```
sudo nmap 10.10.14.24 -p 80 --packet-trace --disable-arp-ping -Pn -n --reason -sT 
```

### <span class="red-command">UDP Port Scan</span>
```
sudo nmap 10.10.14.24 -F -sU -oA nmap/udpscan
```

## **Documenting the results**
When running nmap, get the nmap output in all formats via <span class="command">-oA</span> flag. Once done, we can convert the `output.xml` file to `output.html` via `xsltproc`.  
```
xsltproc output.xml -o output.html
```

### <span class="red-command"></span>
### <span class="red-command"></span>
### <span class="red-command"></span>