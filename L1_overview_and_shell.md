# Overview_and_shell

# Using the shell

打開終端機時，你會看到一個 `prompt` 長得像這樣

``` 

missing :~$
```

`prompt` 中文翻作**命令提示字元**

1. missing -> 現在路徑
2. ~ -> 當前使用者目錄的縮寫
3. $ -> 你不是root使用者

## echo

`echo hello` 會print出hello， `echo` 會把後面的argument用空格切開然後print出來

1. `echo` My Photos

## Bash Shell

* Bash和Python，Ruby一樣，是一個程式語言，所以就會有variable, conditionals, loops, functions，而bash shell基本上就是ipython的感覺，可以直接互動式產生結果

## 環境變數(Enviroment Variable)

存在 `$PATH` 中的可以呼叫，不然就要把它找出來用，像是下面這樣

``` 

missing:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

missing:~$ which echo

/bin/echo
missing:~$ /bin/echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

```

上式中，echo包含在 `/usr/bin/` 裡面，所以可以被找到，如果沒有在環境變數中，那麼就必須 `/bin/echo $PATH`

## 操控Shell (Navigating the shell)

1. 分隔符 Linux/macOS : `/` , Windows: '\\'
2. 從 `/` ， `~` 的就是絕對路徑，其他的都是相對路徑
3. `../..` 是可以被使用的

``` 

missing:~$ pwd
/home/missing

missing:~$ cd /home

missing:/home$ pwd
/home

missing:/home$ cd ..

missing:/$ pwd
/

missing:/$ cd ./home

missing:/home$ pwd
/home

missing:/home$ cd missing
missing:~$ pwd
/home/missing

missing:~$ ../../bin/echo hello
hello # 

```

## ls, informative command!

`ls -l` : list with long listing format - 會給我們一大把資訊
 `ls --help`

``` 

missing:~$ ls -l /home
drwxr-xr-x 1 missing  users  4096 Jun 15  2019 missing

```

## Permissions

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

再來繼續解釋 `1 missing  users  4096 Jun 15  2019 missing`

`1` : 佔用的節點(inode)數量，如果剛檔案是目錄，那這個數值與該目錄下的子目錄數量有關

`missing` : 該檔案的所有者(可能是當前使用者，也可能不是)

`users` : 該檔案的所屬群組

`4096` : 該檔案的大小

`4096 Jun 15  2019` : 該檔案最後一次被修改的時間(modified time)，依序為 `月份` ， `日期` ， `時間`

`missing` : 檔名

# mv, cp, mkdir

`mv` : move
`cp` : copy
`mkdir` : make a niew directory

* 全部都可以 --help或是 `man mv` ,    `man cp` ,    `man mkdir` 查看怎麼用
* man的意思是 manual page(手冊)

# 關於重定向 (Connecting Program)

在shell中，程式碼有兩種主要的**流向**

1. 流入(input stream)
2. 流出(output stream)

在正常的情況下，input stream和output stream都會是你的終端機(你輸入指令，以及在terminal看到輸出指令)

但你仍然可以重新改變他們的流向，例如以下的例子

``` 

# 把hello的output stream丟到 `hello.txt` 檔案中
missing:~$ echo hello > hello.txt
missing:~$ cat hello.txt
hello
missing:~$ cat < hello.txt
hello
missing:~$ cat < hello.txt > hello2.txt
missing:~$ cat hello2.txt
hello

```

`>>` : append模式， `>` : 寫入，前者會在檔案中加入output stream，後者會直接把檔案內容直接覆蓋掉。

`|` : pipe 指令可以讓你將左右程式碼串連起來，該output stream會被pipe指令後面的指令繼續操作。

``` 

# 列出根目錄的詳細資訊，並且列出最後一行，你可以在 man tail中查看參數意義
missing:~$ ls -l / | tail -n1
drwxr-xr-x 1 root  root  4096 Jun 20  2019 var
# 你可以一直pipe下去，沒問題的
curl --head --silent google.com | grep --ignore-case content-length | cut --delimiter=' ' -f2
219

```

我們在data wrangling(Chapter 4)會提到使用pipe帶來的更多好處

# 通用且強大的工具 sudo

在多數的Unix-like系統中，有一種使用者非常特別， `root` 使用者， `root` 使用者幾乎擁有所有的權限，可取得，創建，讀取，更新，刪除系統中任何檔案，而通常你不會一直使用 `root` 使用者登入，這樣很容易不小心把系統搞壞，通常我們只有使用 `sudo` 指令時，才會告訴系統說，我現在要換成 `root` (或稱為 `super user` )，當你遇到一些權限不足的錯誤時(permission denied errors)，很有可能是你必須切換到 `root` 使用者來進行操作，所以一但使用 `root` 使用者，要確認清楚接下來的指令是不是真的你要做的，不然就悲劇了。

另一項你一定得使用 `root` 進行操作的就是 `sysfs` 檔案系統，在 `/sys` 之下 `sysfs` 會把kernel參數當成檔案show給你看，因此你可以輕易的重新配置kernel，不需要任何複雜的工具，不過要注意的是， `sysfs` 指令在Windows上以及macOS上是不存在的。

例如你螢幕的亮度知訊事實上會在一個叫做 `brightness` 的檔案之下
 `/sys/class/backlight`

把值寫入該檔案我們就可以調整螢幕亮度，基本上會長得像是下面這樣

``` 

$ sudo find -L /sys/class/backlight -maxdepth 2 -name '*brightness*'
/sys/class/backlight/thinkpad_screen/brightness
$ cd /sys/class/backlight/thinkpad_screen
$ sudo echo 3 > brightness
An error occurred while redirecting file 'brightness'
open: Permission denied
```

以上你可以看到權限不足的錯誤(Permission denied)，所以我們換個方法，先輸入一個值，然後複製到brightness之中

 `echo 3 | sudo tee brightness`

# 下一步

從上面的事情你可以看到透過bash shell你可以完成一些很基本的任務，你應該要能夠操縱著shell來找到那些你有興趣的檔案，以及使用那些最基本的功能，下一個Chapter我們會介紹怎使用bash shell處理以及自動化更多複雜的任務

# 練習

1. 在一個新的資料夾下新增 `tmp`
2. 看一下 `touch` 怎麼用(man是你的好夥伴)
3. 用 `touch` 在 `tmp` 中新增一個叫做semester的檔案
4. 把下面的資訊寫入，一次寫一行

``` 

#!/bin/sh
curl --head --silent https://missing.csail.mit.edu

```

The first line might be tricky to get working. It’s helpful to know that # starts a comment in Bash, and ! has a special meaning even within double-quoted (") strings. Bash treats single-quoted strings (') differently: they will do the trick in this case. See the Bash quoting manual page for more information.

5. 試著執行該檔案，使用 `./semester` - 會遇到Permission denied，試著透過 `ls -l` 來了解為何不可執行該檔案? - `ls -l` 之後可以看到 `-rw-r--r--` ，表示為一般檔案，三種使用者都無法執行他，意思就是說，這檔案本來就沒辦法被執行
6. 使用 `sh` 直譯器，把 `semester` 當做第一個引數，試試看這樣能不能執行，瞭解看看為什麼這樣能跑，但直接輸入 `./semester` 不能跑?
7. 用man看一下 `chmod`
8. 使用 `chmod` 來調整，讓我們可以只輸入 `./semester` 就能夠執行該檔案，而沒有一定要輸入 `sh semester` ，並且比較之中的差異

   * ANS : `chmod +x semester` 讓semester變得可被執行，就可以直接 `./semester`

   * ANS2 : 比較的部分 : `./semester` 也是用bash執行，但是在還沒讀取到第一行 `#!/bin/sh` 時就不能跑了，或許chmod +x 某種程度上也是貼上一個tag告訴他可以用sh執行(?)
   
   * ANS3 : 權限管理可以使用 `chmod [u|g|o] [+|-] [r|w|x]` 的組合來進行

     * user / group / other 
     * + or -
     * read / write / excute

9. 使用 `|` 以及 `>` 來寫入最後變更日期，而這個最後變更日期是semester的output stream出來的，你要寫入 `last-modified.txt` 這個檔案。

   * ANS : `./semester | grep "Date" | tee > last-modified.txt`

   * ANS2 : 解釋上面，先用bash跑 `./semester` ，然後擷取有關"Date"的部分，接著copy output stream變成input stream 接著寫入 `last-modified.txt`

   * ANS3 : 補充解釋 `./semester | grep "Date" | > last-modified.txt` 這樣是行不通的，因為最後的指令沒有input stream， `last-modified.txt` 裡面會是空的，gg。

# additinal matrials

* 關於權限，from 跟阿銘學Linux

``` 

d : 目錄(directory)

* : 一般檔案

l : 連結檔(link file)
b : 區塊設備(例如/dev/sda, /dev/video)
c : 序列埠設備檔(又稱字元設備檔, 例如鍵盤，滑鼠，印表機，tty終端)
s : 通訊端檔(socket，用於行程之間的溝通，講到MySQL時會用到這樣的檔案)
```

* 關於ls -l, 以前常用的ls -lh 可以display human understandable 的 檔案大小

 `(base) YuLong@wangyuxuandeAir:~/Desktop$ ls -lh`

``` 

drwxr-xr-x  51 YuLong  staff   1.7K  3  4 02:38 Working_Area
-rw-r--r--   1 yltsai  staff    48K  2 26 10:16 ABCDE.eddx
```

* [bash shell中，單引號、雙引號，反引號的區別以及各種括號的區別](https://www.itread01.com/p/129946.html)
* [簡明 Linux Shell Script 入門教學](https://blog.techbridge.cc/2019/11/15/linux-shell-script-tutorial/)

  
