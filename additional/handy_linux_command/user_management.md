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

# Permissions

依序解釋 `drwx-xr-x`

`d` : `missing` 是一個資料夾(directory)，也可能會出現其他的

`s` : `missing` 是一個socket通訊檔案

`-` : `missing` 是一個一般檔案

`l` : `missing` 是一個連結檔

`b` : `missing` 是一個區塊設備(例如 `dev/sda` )

`c` : `missing` 序列埠設備檔(例如鍵盤滑鼠印表機tty終端)
``

`rwxr-xr-x` : 這三個符號表示了目前owner對於 `missing` 的權限 :  9個digits拆成3個一組，個別代表了3個部分的使用者權限

    分別為(rwx)(r-x)(r-x) (檔案所有者)(使用者群組)(其他使用者)

    r : read 可讀, w : write 可寫, x : excute 可執行, - : 不可以!

所以 `rwxr-xr-x` : 

檔案擁有者 : 可讀可寫可執行

使用者群組 : 可讀不可寫可執行

其他使用者 : 可讀不可寫可執行

### command

1. chmod - change mode
2. chown - change owner
3. chgrp - change group
4. cat /etc/group - list all the groups

### code

r : 4

w : 2

x : 1

| code | meaning                                                   | note |
|------|-----------------------------------------------------------|------|
| 700  | 檔案擁有者可讀可寫可執行，群組和其他使用者都不能用                 |      |
| 077  | 檔案擁有者是廢物，不可讀不可寫不可執行，其他群組和使用者可讀可寫可執行 |      |
| 777  | 所有人都可讀可寫可執行，基本上是非常危險的作法                    |      |
| ?00  | 設定檔案擁有者的行為，其他人都不可以動作，屬於比較安全的做法         |      |

再來繼續解釋 `1 missing  users  4096 Jun 15  2019 missing`

`1` : 佔用的節點(inode)數量，如果剛檔案是目錄，那這個數值與該目錄下的子目錄數量有關

`missing` : 該檔案的所有者(可能是當前使用者，也可能不是)

`users` : 該檔案的所屬群組

`4096` : 該檔案的大小

`4096 Jun 15  2019` : 該檔案最後一次被修改的時間(modified time)，依序為 `月份` ， `日期` ， `時間`

`missing` : 檔名
