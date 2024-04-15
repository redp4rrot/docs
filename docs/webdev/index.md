# **Fundamentals**

### <span class="webdev">Coding style guide</span>
 What if github never existed?  
 In that case, maintaining a codebase becomes even more challenging as compared to writing code. The style in which linux kernel was written, followed some of its own principles to write good code.
 [Linux kernel coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html){:target="_blank"} is a short document describing the preferred coding style for the linux kernel.

1. **Verbosity in variable name** - Less is the scope of variable, less verbose it must be. Meaning, keeping variable names short is a good practice if that variable is defined within a fucntion whose scope is less.
2. Any code block should’nt have more than 4 indents.
3. An empty line depicts the starting of a logic block.
4. <span class="green-command">Never copy code</span>, even if it is guaranteed to work.
5. <span class="green-command">Never use</span> terminal as sudo unless required.
6. If you have multiple conditions in a <span class="green-command">if</span> or a for loop, then specify each condition in new line. (Increases readability)
7. Private functions inside classes <span class="green-command">should start with an underscore _</span>
8. <span class="green-command">Always leave a space</span> after a <span class="green-command">,</span> (Just a programming principle)
9. If a function is doing something, its name must be a <span class="green-command">verb</span>. For example, if a function is creating a 3D geometry in space then its name should be something like createGeometry().
10. Variable names <span class="green-command">must be easy to pronounce</span>.
11. Any functions that are private but visible outside should start with _ so that anyone trying to call it will know it is a private method and cannot be used from outside. 
12. If the function is not visible outside and is only defined in the local scope then it need not have <span class="green-command">_</span>.
13. Logical operations should be in one block, means, Always leave a space after a logical block.
14. Don’t use a variable that is not passed to a function. For example, using global variables within a function without passing them to the function.
15. Each function should not be more than 30 lines, thereby decreasing the Bug Exposure.
16. <span class="green-command">No trailing whitespaces</span> should be present.
17. Array variable names <span class="green-command">should end with</span> an <span class="green-command">s</span> to indicate that the variable is a collection.
18. Transient variables <span class="green-command">should have a block scope</span>. Therefore, declare the transient variables using let because let has a block scope.
19. <span class="green-command">var</span> has a stronger scope as compared to <span class="green-command">let</span>.

### <span class="webdev">Python Zen</span>
``` python
import this
```
??? tip "The Zen of Python, by Tim Peters"

    Beautiful is better than ugly.<br>
    Simple is better than complex.<br>
    Complex is better than complicated.<br>
    Flat is better than nested.<br>
    Sparse is better than dense.<br>
    Readability counts.<br>
    Special cases aren't special enough to break the rules.<br>
    Although practicality beats purity.<br>
    Errors should never pass silently.<br>
    Unless explicitly silenced.<br>
    In the face of ambiguity, refuse the temptation to guess.<br>
    There should be one-- and preferably only one --obvious way to do it.<br>
    Although that way may not be obvious at first unless you're Dutch.<br>
    Now is better than never.<br>
    Although never is often better than *right* now.<br>
    If the implementation is hard to explain, it's a bad idea.<br>
    If the implementation is easy to explain, it may be a good idea.<br>
    Namespaces are one honking great idea -- let's do more of those!<br>

### <span class="webdev">VSCode keyboard shortcuts</span>

| Keys                | Description                          |
| -----------         | ------------------------------------ |
| **Fn + F2**         | Click on any word and press fn + F2 to rename that word in all instances of it.  |
| **Hold ALT**        | Hold the Alt key and now if you click on different words (one by one), then you will be able to edit multiple words using a single  cursor. |
| **SHIFT + TAB**     | move the selected code block by one indent back. |
| **Fn + F12**        | Click on a function once and press fn + F12 to see the function definition.  |
| **CTRL + Y**        | Redo  |

**Descriptive but handy tricks**  
Move the line downwards:  
1. Place the cursor anywhere in the desired line.  
2. Press and **hold** the **ALT** key.  
3. Press the down key if you want to move the line below, for example moving line number 12 to line number 13.

### <span class="webdev">Git and version control</span>

Your Github username - `Parrot`    
Role - Software developer intern at RedParrotHQ   
Task - Set up SSH access to your dev machine, fork the `redparrot` repository (this is a private repository) and submit a PR.  
The RedParrot's project repository URL is `https://github.com/RedParrotHQ/redparrot.git`. Since you're a software developer and you are requested to submit a PR but you don't have write access to this repository because you're just an intern, assuming you don't know about fundamental software development principles.

#### <span class="green-command">Clone the repository</span>  
First things first, you have to clone the repository to your local machine and for that you need `Read` permissions on the remote repository - `https://github.com/RedParrotHQ/redparrot.git`. Therefore, an admin of RedParrotHQ has invited you to join the organization.  
```
git clone git@github.com:RedParrotHQ/redparrot.git .
```
This should download the repository to your current working directory through SSH (since we've used the SSH url)

#### <span class="green-command">Fork the repository</span>  
The `redparrot` repository is not forked yet. Once you fork the repository, you'll be able to see the repository at:  
`https://github.com/Parrot/redparrot.git`

#### <span class="green-command">Setup SSH access</span>  
In order to setup tracking between your cloned repository with your forked repository. You need write access to your fork using github CLI.
For that, setup SSH access to your github account using ssh keys.

Generate SSH keys if you're booting in your system for the first time.  
```
ssh-keygen -t rsa -b 4096 -C "Parrot@redparrot.in"
```
By default ssh keys are located at <span class="green-command">~/.ssh/</span>. Let's say your public key is located at <span class="green-command">~/.ssh/id_rsa.pub</span> and the private key at <span class="green-command">~/.ssh/id_rsa</span>. Once the keys are generated, the public key needs to be added to your github account under-  
<span class="green-command">Settings > SSH and GPG keys > New SSH key</span>

Test if you can access your github account through the CLI.  
```
$ ssh -T git@github.com
Hi Parrot! You've successfully authenticated, but GitHub does not provide shell access.
``` 

#### <span class="green-command">Set the remote</span>  
Now you can control and update your fork through CLI. First, try to check the existing remotes.
_A remote is a unique name which represents a repository through a URL_. For instance, origin refers to your own fork. You can push any peice of code to your fork.

```
$ git remote -v
origin  git@github.com:Parrot/redparrot.git (fetch)
origin  git@github.com:Parrot/redparrot.git (push)
```

Let's say you own a second github account (username: Parrot2) and you want your `origin` to point to Parrot2's fork. Here's how to do it. 
```
git remote set-url origin https://github.com/Parrot2/redparrot.git
```

#### <span class="green-command">Add a new remote</span>  
What if you want to fetch a branch called `beta` from the `RedParrotHQ/redparrot` repo and push changes on top of it?
To accomplish this, we've to set RedParrotHQ as a remote that will point to the organisation's private repository.
```
git remote add RedParrotHQ git@github.com:RedParrotHQ/redparrot.git
```

#### <span class="green-command">Fetch branches from a remote</span>  
Fetching branch `beta` from RedParrotHQ
```
git fetch RedParrotHQ beta
git checkout beta
```

#### <span class="green-command">Push local branches to remote</span>   
Now that you have the `beta` branch on your local machine, the next step is to push this branch to your fork.(origin)
Next, set the upstream branch as `origin/beta` for tracking any changes that will be made to `beta` branch in future.
```
git push origin beta
git push --set-upstream origin beta
```

#### <span class="green-command">Commiting and pushing changes</span>     
This is where everything clicks together. Submitting a PR.

```
git checkout master
git checkout -b task
git push origin task
git push --set-upstream origin task
git add .
git commit -m 'Task completed'
git push
```

#### <span class="green-command">Opening a Pull Request (PR)</span>     
This is the only thing that you are supposed to do using the GitHub GUI.

#### <span class="green-command">Advanced version control: Rebase</span>  
Role - Software developer intern at RedParrotHQ   
Task - The master branch went 7 commits ahead when you were learning how to submit your first PR. You are requested to push your commit on top of the latest master branch and update the PR.

What is <span class="green-command">rebase</span>?  
Referring to the current context, when you are making commits to your fork, the master branch was updated(means it had some merges). This would result in something like:  
!!! info "Sync Fork"

    This branch is 7 commits behind RedParrotHQ/redparrot:master.

To update the master branch at your fork(`https://github.com/Parrot/redparrot.git`), simply `Sync Fork` to sync the fork with RedParrotHQ's master.  
Next, you've to update the local branch:
```
git checkout master
git pull
```

Now checkout the `task` branch, which needs to be rebased.
```
git checkout task
```

Performing rebase on branch `task`
```
git rebase -i master
```
<span class="green-command">-i</span> refers to the interactive rebase.

You'll see something like this:
```
pick 156adcb Task completed

# Rebase abc5d8..156adcb onto afbd5d9 (1 command)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified); use -c <commit> to reword the commit message
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
```
!!! tip "VSCode plugins"

    VSCode Extension - <span class="green-command">Git graph</span>  
    View a Git Graph of your repository, and perform Git actions from the graph.

This is opened in the `nano` editor by default. Simply exit and save changes. This completes the rebase assuming there were no merge conflicts. We will dive deeper as the practicality of this module increases.

### <span class="webdev">Using the browser dev tools</span>    
Even if you know how to develop a software but if you're not a good debugger, then you'll really struggle a lot to find bugs. Usually, in a corporate enterprise codebase, there are thousands of lines of code in one single file. And there are multiple files with the exact same name located in different folders. It won't be anyone's cup of tea to keep more than 8 stacks/threads in their head to find that one bug. A bug has some parameters like - severity, impact, exposure, type etc. The basic steps for debugging anything are:

1. Ask questions from yourself, like - `The request is sent by the APIClient. How the controller is handling this API endpoint? Okay, this endpoint is taking the request body to create an object and then this object is posted to some other handler. Maybe that handler failed processing this object the way its supposed to?`
2. Reduce the bug exposure instead of finding an alternative way to bypass the bug which is called as a `PATCH`. The patch may fix the bug in some cases but it will really help the bug to hide more deeper in the system, thereby increasing bug exposure.
3. To debug something, it depends on the type of bug i.e frontend, backend, devops etc. Let's say the bug is in front end feature.
4. You can simply add a breakpoint in the browser dev tools and then trigger the execution flow. When the control hits the line at which breakpoint is marked, you can simply hover on the variables, functions or anything to see what's really going on. At this point,
unless you're high on drugs, it is close to impossible for the bug to still hide. 


### <span class="webdev">Setting up Aliases</span>
It makes no sense to write a same long command 100 times to do the exact same thing everytime. This is where aliases come into picture. 