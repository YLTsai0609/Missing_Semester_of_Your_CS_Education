# User Management

## 01 `useradd` - create new user

 `useradd test_purpose -c "fresh user to test your repo" -s /bin/bash -m -d /home/test_purpose/`

   
`-c` :  commit message
   
`-s` :  set shell binary

`-d` : set default directory

`-m` : create the directory if not exist.

## 02 `passwd` set password to your new user

 `sudo passwd test_purpose`

## 03 Misc cmd to make your work more fluent

| cmd      | uasge                | note |
|----------|----------------------|------|
| `whoami` | check current user |      |
| `su - l` | switch user in current terminal(any user) |      |
| `ls /home/` |list all common users|
| `less /etc/passwd` | list all user(real people and system user)|
| `w` |check current activated users|

## Trouble Shooting

1. [Why is the home directory not created when I create a new user?](https://unix.stackexchange.com/questions/182180/why-is-the-home-directory-not-created-when-i-create-a-new-user)
