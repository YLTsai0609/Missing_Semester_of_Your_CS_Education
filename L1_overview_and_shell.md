# Overview_and_shell

# Using the shell

打開終端機時，你會看到一個`prompt`長得像這樣
```
missing :~$
```
`prompt`中文翻作**命令提示字元**
1. missing -> 現在路徑
2. ~ -> 當前使用者目錄的縮寫
3. $ -> 你不是root使用者

## echo
`echo hello`會print出hello，`echo`會把後面的argument用空格切開然後print出來
1. `echo` My Photos

## Bash Shell
* Bash和Python，Ruby一樣，是一個程式語言，所以就會有variable, conditionals, loops, functions，而bash shell基本上就是ipython的感覺，可以直接互動式產生結果

## 環境變數(Enviroment Variable)
存在`$PATH`中的可以呼叫，不然就要把它找出來用，像是下面這樣

```
missing:~$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

missing:~$ which echo

/bin/echo
missing:~$ /bin/echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

```

上式中，echo包含在`/usr/bin/`裡面，所以可以被找到，如果沒有在環境變數中，那麼就必須`/bin/echo $PATH`

## Shell中幾個常見用法
1. 分隔符 Linux/macOS : `/`, Windows: '\\'
2. 從`/`，`~`的就是絕對路徑，其他的都是相對路徑
3. `../..`是可以被使用的

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
依序解釋`drwx-xr-x`

`d` : `missing` 是一個資料夾(directory)

    `rwxr-xr-x` : 這三個符號表示了目前owner對於`missing`的權限 :  9個digits拆成3個一組，個別代表了3個部分的使用者權限

    分別為(rwx)(r-x)(r-x) (檔案所有者)(使用者群組)(其他使用者)

    r : read 可讀, w : write 可寫, x : excute 可執行, - : 不可以!

所以`rwxr-xr-x` : 

檔案擁有者 : 可讀可寫可執行

使用者群組 : 可讀不可寫可執行

其他使用者 : 可讀不可寫可執行

再來繼續解釋`1 missing  users  4096 Jun 15  2019 missing`

`1` : 佔用的節點(inode)數量，如果剛檔案是目錄，那這個數值與該目錄下的子目錄數量有關

`missing` : 該檔案的所有者(可能是當前使用者，也可能不是)

`users` : 該檔案的所屬群組

`4096` : 該檔案的大小

`4096 Jun 15  2019` : 該檔案最後一次被修改的時間(modified time)，依序為`月份`，`日期`，`時間`

`missing` : 檔名

# mv, cp, mkdir
`mv` : move
`cp` : copy
`mkdir` : make a niew directory
* 全部都可以 --help或是`man mv`, `man cp`, `man mkdir`查看怎麼用
* man的意思是 manual page(手冊)

# additinal matrials
* 關於權限，from 跟阿銘學Linux
```
d : 目錄(directory)
- : 一般檔案
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
  
TODO : Connecting Program