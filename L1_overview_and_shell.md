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
`echo hello`會print出hello，`echo`會把後面的argument用空切開然後print出來
1. `echo` My Photos

## Bash Shell
* Bash和Python，Ruby一樣，是一個程式語言，所以就會有variable, conditionals, loops, functions，而bash shell基本上就是ipython的感覺，可以直接互動式產生結果

## 環境變數
存在`$PATH`中的可以叫，不然就要把它找出來用，像是下面這樣

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
1. 分隔符 Linux/macOS : `/`, Windows: '\'
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

## ls詳細解釋
`ls -l` : list with long listing format - 會給我們一大把資訊
`ls --help`

```
missing:~$ ls -l /home
drwxr-xr-x 1 missing  users  4096 Jun 15  2019 missing

```

依序解釋`drwx-xr-x`

d : `missing` 是一個資料夾(directory)
ewx : 這三個符號表示了目前owner對於`missing`的權限 :  the owning group (users), and everyone else respectively have on the relevant item
- : 當前user對此資料夾沒有操作權限
[TODO] 操作權限