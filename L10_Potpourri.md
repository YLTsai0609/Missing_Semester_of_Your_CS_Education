# Table of Contents
Keyboard remapping
Daemons
FUSE
Backups
APIs
Common command-line flags/patterns
Window managers
VPNs
Markdown
Hammerspoon(desktop-automation-on-macOS)
Booting + Live USBs
Docker, Vagrant, VMs, Cloud, OpenStack
Notebook programming
GitHub

# Keyboard remapping

Highlight
* macOS - karabiner-elements, skhd or BetterTouchTool
* Linux - xmodmap or Autokey
* Windows - Builtin in Control Panel, AutoHotkey or SharpKeys
* QMK - If your keyboard supports custom firmware you can use QMK to configure the hardware device itself so the remaps works for any machine you use the keyboard with.

# Daemons

`Daemons : 後台程式`

大部分的電腦都有跑在背景的程式，在bash中通常可以加上`d`來表示，例如`sshd`就是ssh daemon的意思

在Linux中，`systemd`應該是最常使用以及設定後台的程式，你可以run`systemctl status`來檢查目前的後台程式(可以在ubuntu上測試)，`systemctl`可以搭配`enable`, `disable`, `start`, `stop`, `restart`, `status`來使用

而`systemd`可以用來設置一些你要想放在後台運行的程式，下面就是一個範例透過daemon來跑一個簡單的python app

```
# /etc/systemd/system/myapp.service
[Unit]
Description=My Custom App
After=network.target

[Service]
User=foo
Group=foo
WorkingDirectory=/home/foo/projects/mydaemon
ExecStart=/usr/bin/local/python3.7 app.py
Restart=on-failure

[Install]
WantedBy=multi-user.target

```
* 當然，如果你只是想要在一個固定頻率下跑一個程式，那麼沒有必用使用一個客製化的deman，可以用[`cron`](http://man7.org/linux/man-pages/man8/cron.8.html)，這是一個已經寫好的daemon，幫助你每天固定跑程式碼

## Additinal Material

* google keyword : systemd equivalent in macOS
  * [stackoverflow https://stackoverflow.com/questions/47934081/does-the-command-systemctl-and-service-exists-on-linux-only-and-not-mac](https://stackoverflow.com/questions/47934081/does-the-command-systemctl-and-service-exists-on-linux-only-and-not-mac)