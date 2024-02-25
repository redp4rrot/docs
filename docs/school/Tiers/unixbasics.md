# **Fundamentals**

### Control the OS

!!! quote "Own it"

    With control, comes power

The most crucial power that is needed to become a system administrator is having the ability to control it as if you really own everything. 

### Prompt description
The prompt can be customized using special characters and variables in the shell’s configuration file (.bashrc for the Bash shell).
You can use tools such as [powerline](https://github.com/powerline/powerline){:target="_blank"}, [bash prompt generator](https://bash-prompt-generator.org/){:target="_blank"} etc. to customize the prompt.

![alt text](/school/Tiers/prompt.png)

### Getting started
#### <span class="red-command">General</span>
1. The shell command is too complex!

    Even after learning the basics, if a command appears quite complex, we can break it down into understandable peices using - [explainshell](https://explainshell.com/){:target="_blank"}

2. `~` is the home directory of the currently logged in user.

#### <span class="red-command">System Information</span>
Each manual page has a short description available within it. This tool searches the descriptions for instances of a given tool.

```
apropos <keyword>
```

`uname`

``` bash
winusr@RYZEN7-4800H:/var/www/quadocs$ uname -a
Linux RYZEN7-4800H 5.15.146.1-microsoft-standard-WSL2 #1 SMP Thu Jan 11 04:09:03 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
```

Kernel name - Linux<br>
Host name - RYZEN7-4800H<br>
kernel release - 5.15.146.1-microsoft-standard-WSL2<br>
kernel version - #1 SMP Thu Jan 11 04:09:03 UTC 2024<br>

#### <span class="red-command">Navigation</span>

| Command     | Description                          |
| ----------- | ------------------------------------ |
| `ls`        | List directory contents  |
| `ls -l`     | Add the -l option to display more information on those directories and files |
| `ls -la`    | List all files of a directory |
| `cd`        | Navigate to the home directory of the current user |
| `ls -la /var/`    | List all files present in the `/var` directory |
| `cd -`    | We can quickly jump back to the directory we were last in|

What the heck is <span class="command">drwxr-xr-x</span> ?
``` bash
username@hostname:~$ ls -l /etc/passwd

- rwx rw- r--   1 root root 1641 May  4 23:42 /etc/passwd
- --- --- ---   |  |    |    |   |__________|
|  |   |   |    |  |    |    |        |_ Date
|  |   |   |    |  |    |    |__________ File Size
|  |   |   |    |  |    |_______________ Group
|  |   |   |    |  |____________________ User
|  |   |   |    |_______________________ Number of hard links
|  |   |   |_ Permission of others (read)
|  |   |_____ Permissions of the group (read, write)
|  |_________ Permissions of the owner (read, write, execute)
|____________ File type (- = File, d = Directory, l = Link, ... )
```
#### <span class="red-command">Terminal Shortcuts</span>

| Keys             | Description                          |
| -----------      | ------------------------------------ |
| **CTRL + R**     | **:octicons-search-16:** Search through the command history using the shortcut [Ctrl] + [R] and type some of the text that we are looking for  |
| **CTRL + L**       | **:material-broom:** Clear the terminal |

#### <span class="red-command">File and directories<span>
<span class="command">touch</span> (create a file)
```
$ touch hello.txt
```

<span class="command">mkdir</span> (create directories in the filesystem)

```bash
$ mkdir -p Storage/local/user/documents
```

<span class="command">tree</span> (visualize the files in a tree)
```bash
$ tree .
```

<span class="command">mv</span> (move + rename)

This will move `code.py` from the current working directory to /var/www/html and rename it to `new_code.py`
```
$ mv code.py /var/www/html/new_code.py
```

<span class="command">cp</span> (file copying)

This will copy all the files having an extension of `py` from the current working directory to /var/www/html
```
$ cp *.py /var/www/html
```

#### <span class="red-command">Text editors</span>
<span class="command">vim</span>

<span class="command">nano</span>

#### <span class="red-command">Locating Files and directories</span>
<span class="command">which</span>

``` bash
r3d@parrot$ which curl
/usr/bin/curl
```

<span class="command">locate</span>

<span class="command">find</span>