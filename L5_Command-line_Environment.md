# Intro
* 這一節裡面我們會講到多個招式讓你用shell來加速你的工作流程，之前我們講了蠻多指令用法，現在我們會講怎麼同時執行他們，並且追蹤，這樣的技巧可以讓你不論在本地端還是遠端都能夠增加工作效率

# Job Control
`ctrl + C` : 中斷
`kill` : 殺掉進程
`fg`, `bg` : 把程式拉到前景，丟到背景，`bg`等同於(`ctrl + Z`)
`jobs`: 列出目前的使用者控制的process
`ps` : 列出所有進程(process status)
`&` : 丟到背景
`nohup` : 丟到背景而且把stdout寫到nohup.out，可以被重定向
```
$ sleep 1000
^Z
[1]  + 18653 suspended  sleep 1000

$ nohup sleep 2000 &
[2] 18745
appending output to nohup.out

$ jobs
[1]  + suspended  sleep 1000
[2]  - running    nohup sleep 2000

$ bg %1
[1]  - 18653 continued  sleep 1000

$ jobs
[1]  - running    sleep 1000
[2]  + running    nohup sleep 2000

$ kill -STOP %1 - 可以用編號而非pid
[1]  + 18653 suspended (signal)  sleep 1000

$ jobs
[1]  + suspended (signal)  sleep 1000
[2]  - running    nohup sleep 2000

$ kill -SIGHUP %1
[1]  + 18653 hangup     sleep 1000

$ jobs
[2]  + running    nohup sleep 2000

$ kill -SIGHUP %2

$ jobs
[2]  + running    nohup sleep 2000

$ kill %2
[2]  + 18745 terminated  nohup sleep 2000

$ jobs

```

# 多工(Terminal Multiplexers)
* [tmux for ubunutu](http://man7.org/linux/man-pages/man1/tmux.1.html)

# 別稱(Aliases)
```
# Make shorthands for common flags
alias ll="ls -lh"

# Save a lot of typing for common commands
alias gs="git status"
alias gc="git commit"
alias v="vim"

# Save you from mistyping
alias sl=ls

# Overwrite existing commands for better defaults
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format

# Alias can be composed
alias la="ls -A"
alias lla="la -l"

# To ignore an alias run it prepended with \
\ls
# Or disable an alias altogether with unalias
unalias la

# To get an alias definition just call it with alias
alias ll
# Will print ll='ls -lh'

```

# Dotfiles

一些組態檔
bash : `.bashrc`, `.bash_profile`
git : `~/.gitconfig`
vim : `~/.vimrc`,`~/.vim` folder
ssh : `~/.ssh/config`
tmux : `~/.tmux.conf`

1. 這些東西都非常好移植，cp就可以移植了
2. 最好一直確保備份著他們，這使你在任何地方都有相同的工作環境
3. [也可以參考別人的config](https://github.com/search?o=desc&q=dotfiles&s=stars&type=Repositories)
4. 可以根據機器來客製化

```
   if [[ "$(uname)" == "Linux" ]]; then {do_something}; fi

# Check before using shell-specific features
if [[ "$SHELL" == "zsh" ]]; then {do_something}; fi

# You can also make it machine-specific
if [[ "$(hostname)" == "myServer" ]]; then {do_something}; fi
```

## 遠端機器(Remote Machine)
SSH : Secure Shell
`ssh foo@bar.mit.edu`
通常還會搭配執行使用指令，例如
`ssh foobar@server ls` 遠端之後ls
你要安全連線總要有鑰匙吧
ssh key放在`~/.ssh/id_rsa`
還有ssh-keygen，可以google一下
從短端機器copy檔案
`ssh + tee` : cat localfile | ssh remote_server tee serverfile
`scp`
`rsync`

## Port Forwarding
在很多場景下你比須給定本地端的port讓軟體跑起來，像是`localhost:PORT` or `127.0.0.1:PORT`
但是如果你希望這個port可以連到遠端，應該要怎麼做?

這樣的招數叫做`port forwarding`
