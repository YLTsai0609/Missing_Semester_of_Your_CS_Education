# L2 Shell Tools and Scripting 

# Variables

在command line可以直接指定變數

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ foo=bar
(base) YuLong@MacBook-Pro:~/Desktop$ echo $foo
bar
```

shell預設是空格即間隔，這和其他程式語言(例如Python)不太一樣，所以以下不會work

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ foo = bar
-bash: foo: command not found
```

單引號和雙引號的字串格式都是被接受的

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ echo "HELLO"
HELLO
(base) YuLong@MacBook-Pro:~/Desktop$ echo 'abc'
abc
```

但雙引號裡面是可以放變數的，如下，變數為 `$foo`

單引號則為plain text(純文字格式)

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ echo "Value is $foo"
Value is bar
(base) YuLong@MacBook-Pro:~/Desktop$ echo 'Value is $foo'
Value is $foo
```

# Functions

shell也能夠有邏輯判斷，迴圈，函數等，以下示範函數

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ vi mch.sh
```

以下函數會吃一個positional argument，開新資料夾，並且將當前路徑進入到該資料夾中

``` 

mcd () {
    mkdir -p "$1"
    cd "$1"
}

```

# Special Variables

shell當中設計了不少特殊變數，像是 `$1, $2, $? $*, $@` ，可以參考[這裡](https://www.itread01.com/p/200789.html)，這使得sh檔案更輕便簡潔(也更難讀懂就是了....)，這和shell這門語言的設計理念有關係

| special variable | meaning                             | note |
|------------------|-------------------------------------|------|
| `$0` | file name                           |      |
| `$1` | first positional argument           |      |
| `$2` ~ `$9` | second to ninth positional argument |      |
| `$*` | all of the positional arguments     |      |
| `$#` | number of arguments we gave to the program     |      |
| `$$` | PID which processing the program    |      |
| `$?` | lastest command succeed or not    |  successed -> 0    |

# Special Command

shell 設計了很多方便的command來幫助我們快速的和linux系統互動

`!!` means lastest command, like you don't have a permission.

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ vi /System/Volumes/Data/Users/Shared/macenhance/520974.padl

permission denied

(base) YuLong@MacBook-Pro:~/Desktop$ sudo !!
sudo vi /System/Volumes/Data/Users/Shared/macenhance/520974.padl

```

`||` means or, if failed by first command, try second command.

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ false || echo "Oops failed"
Oops failed
```

`&&` - only run the second command only the first command is successed.

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ false && echo "First command successed"
(base) YuLong@MacBook-Pro:~/Desktop$ True && echo "First command successed"
First command successed

```

`;` - always do the following command

``` 

(base) YuLong@MacBook-Pro:~/Desktop$ True ; echo "First command successed"
First command successed
(base) YuLong@MacBook-Pro:~/Desktop$ False ; echo "First command successed"
First command successed

```

## Example Script

1. 一隻會查找給予的檔案(arguments)中有沒有包含`foobar`，沒有就會加進去到檔案最後一行的一隻script

``` 

#!/bin/bash

echo "Starting program at $(date)" # Date will be substituted

echo "Running program $0 with $# arguments with pid $$"

for file in $@; do
    grep foobar $file > /dev/null 2> /dev/null
    # When pattern is not found, grep has exit status 1
    # We redirect STDOUT and STDERR to a null register since we do not care about them
    if [[ $? -ne 0 ]]; then
        echo "File $file does not have any foobar, adding one"
        echo "# foobar" >> "$file"
    fi
done
```

5. 各種test 可以`man test`，在上面的script中是 `-ne` 表示 `!=`，test要用雙中括號包起來，例如`[[$? -ne 0]]`

6. shell globbing，很類似正則表達式的匹配，但是更方便

   Wildcard - `ls *.py` , `rm foo*`

   Curly braces `{}` - 表示或, `ls *.{py,sh}`

``` 

[19:16](https://www.youtube.com/watch?v=kgII-YWo3Zw&feature=emb_logo)

convert image.{png,jpg}
# Will expand to
convert image.png image.jpg

cp /path/to/project/{foo,bar,baz}.sh /newpath
# Will expand to
cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

# Globbing techniques can also be combined
mv *{.py,.sh} folder
# Will move all *.py and *.sh files

mkdir foo bar
# This creates files foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h
touch {foo,bar}/{a..j}
touch foo/x bar/y
# Show differences between files in foo and bar
diff <(ls foo) <(ls bar)
# Outputs
# < x
# ---
# > y

```

7. 子進程與父進程，參考鳥哥，比較清楚，script中的要進到父進程的話，要export
8. 第一行的直譯器位置，叫做shebang，像是``

 `#!/usr/bin/env python.`

# Shell Tools

## 如何使用command?

  + command --help
  + man --help
  + stackoverflow

## 檔案查找

* `find` 超級實用，以下給出幾個例子

``` 

# Find all directories named src
find . -name src -type d
# Find all python files that have a folder named test in their path
find . -path '**/test/**/*.py' -type f
# Find all files modified in the last day
find . -mtime -1
# Find all zip files with size in range 500k to 10M
find . -size +500k -size -10M -name '*.tar.gz'

```

* `find` 可以同時搭配`exec`，找到之後搭配執行動作

``` 

# Delete all files with .tmp extension
find . -name '*.tmp' -exec rm {} \;
# Find all PNG files and convert them to JPG
find . -name '*.png' -exec convert {} {.}.jpg \;

```

* 通常都會使用pattern，就是上面的Globbing，所以可以多了解這個部分
* `fd`是一個比`find`更使用者友善的指令集，像是他的ouptut會有顏色，預設只用正則表達式，support unicode(可以搜尋中文)，以及其他指令更為直覺等
* 大部分的會同意`find`以及`fd`是好東西，但是他們有時候效能不太好，這時候可以查一下`locate`的使用，`locate`，關於`locate`的更多解釋可以看[這裡](https://unix.stackexchange.com/questions/60205/locate-vs-find-usage-pros-and-cons-of-each-other)

## 程式碼查找

* `grep`可以幫助你這個忙，在`data wrangling`我們會講更多

* `grep`非常多才多藝(versatile)，講師常用的包含參數包含`-c`(算有幾個)，`-v`沒有match pattern的(inverting match)，`-R`，不只在當層，還往更深處找(Recursively)

https://missing.csail.mit.edu/2020/shell-tools/

* `grep -R`可以用非常多方式改進，像是排除`.git`，多cpu查找等

* 以下指令需要下載一些新的指令集，像是`ack`,                               `ag`,                               `rg`，這些指令集都非常好用，有需要的話可以使用

``` 

# Find all python files where I used the requests library
rg -t py 'import requests'
# Find all files (including hidden files) without a shebang line
rg -u --files-without-match "^#!"
# Find all matches of foo and print the following 5 lines
rg foo -A 5
# Print statistics of matches (# of matched lines and files )
rg --stats PATTERN
```

## 找尋shell commands

* `histroy`

搭配一下想找的指令， `history | grep find`

* 另一個很酷的東西，講師自己非常喜歡的則是`history-based autosuggestions`，首先介紹一下[`fish`](https://fishshell.com/) shell, [fish-shell github](https://github.com/fish-shell/fish-shell)，這個東西可以在你的[zsh](https://asciinema.org/a/37390)中
* 其中一點要注意的是，這樣的工具會紀錄你輸入過的東西，所以像是一些敏感資訊，要把它們拿掉，這可以從`.bash_history`或是`.zhistory`中調整

## 資料夾導航

* 可以透過`ln -s`，快速連結到某個資料夾，但是必須在該檔案中設定一個檔案，並對其更改權限
* 直接列出資料夾結構 `tree`,                              `broot`
* 非常優秀的檔案管理`nnn`,                               `ranfger`

## Exercise

* took 90 mins
* backbone, details just mark that
* https://missing.csail.mit.edu/2020/shell-tools/
1. `man ls`，然後用`ls`做到以下事情
  + Q : 列出檔案，包含隱藏的 
  + A : `ls -a`,                               `ls -A`
  + Q : 包含檔案大小資訊，人獨得懂的
  + A : `ls -lh`
  + Q : 列出所有檔案(包含隱藏檔案)，但是是按照新舊順序排序
  + A : `ls -alt`
  + A2 : bouns `ls -altr` : 加上反排序 `-r` : `reverse`
  + A3 : bonus man很長，關鍵是sort, 所以可以 `man ls | grep sort`來查找相關命令
  + Q : 讓輸出有顏色
  + A : `ls -aG`，但是如果預設你的`.bashrc`,                               `.bash_profile`ˇ經有設置，可能就沒差

2. 寫兩個bash function,                               `marco` and `polo`

   1. 執行 `marco` 時，會將當前的工作路徑存在某個地方
   2. 執行 `polo` 時，不管輸入什麼工作路徑，都要進入到 `marco` 儲存的工作路徑
   3. 為了讓debug簡單一點，你可以寫好marco.sh然後把他載入到父進程 `source marco.sh`

   A : 

``` 

   #!/bin/bash

    marco () {
        curr_dir=$PWD
    }

    polo () {
    cd $curr_dir
    }
   ```

   A2 : Hint 把test.sh source到父進程可以快速debug，terminal重開變數就會清掉了

3. 假設以下情境，你有一個很少失敗的命令，但是為了debug，你必須抓到他的output，但是這個過程跑很久容易失敗，寫一隻bash script，把arguments輸入以下script，然後等到他failed，抓出他的standard output以及error streams寫到file中，並且把output以及error stream都print出來，bonus term : 如果你可以算出該程序跑了幾次

   A : 使用 `$?` - 上一個command執行的狀態碼，來進行if-else判定， `>>, >` 來重定向stdout， `2>, 2>>` 來重定向stderr
   A : 萬物皆檔案，先存，再用檔案操作，變數的思考觀點可能會比較難做
   

``` 

    #! /bin/bash
    # 此file會測試某個script，200次，並將output以及錯誤訊息寫到當前目錄中的curr.out
    for i in `seq 1 200`;
    do
        # 把參數的file跑起來，stdout以覆蓋模式存在curr.out，stderr已覆蓋模式存在curr.err
        bash $1 > curr.out 2> curr.err 
        # 如果跑失敗，capture
        
        if [[ $? -ne 0 ]]; then
            # 存在一個file，稱為8_3_result.md
            echo "$i failed" 
            echo "ITERATION $i" >> 8_3_result.md
            echo "STDOUT BLOW" >> 8_3_result.md
            cat curr.out >> 8_3_result.md
            echo "ERROR BLOW" >> 8_3_result.md
            cat curr.err >> 8_3_result.md
            echo "Bug Captured! at iteration $i"
        fi
    # 	echo "$i successed"
    done
    rm curr.out
    rm curr.err

   ```

   

4. 這節課我們講到了`find`以及`-exec`參數，這個組合在檔案操作以及搜尋時非常實用，但是如果我們需要對全部的檔案做操作呢? 例如壓縮成一個zip file，如同你目前所見，命令列會從arguments以及STDIN來收取input，當我們使用`pipe`時，我們將STDOUT連接到STDIN，但是一些命令像是`tar`是從arguments接受input的，將這兩者整合的是`xargs`命令(mac有內建)，該命令會將STDIN也是為arguments，例如`ls | xargs rm`，會將所有現在工作目錄的檔案全部刪除(小心不要做這件事....)，你的任務就是**寫一個command，他會遞迴地找倒在資料夾中所有HTML file而且把他們zip起來，並且注意，你的command甚至要在file name有空白的情況下也能運作(可以看看`xargs`的`-d`參數)**

   **PASS**

5. (進階題) 寫下一個command或是script，找出一個工作目錄中最近其修改的檔案(需要進入資料夾中的資料夾(recursively))，或者更廣義來說，你可以把所有檔案列出來並且按照修改日期排序嗎?

    **PASS**

# additinal matrials

1. shell腳本中的算術運算 - 跟著阿銘學linux，第12章，shell script
2. [Update your bash to 5.0 in order to deubger support on VSCode 2.5k+](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba)
