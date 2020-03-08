# L2 Shell Tools and Scripting 
前面幾個part不小心沒有留記錄而且被刪掉了，囧

幾個重點

1. 可以自己寫script
```
mcd () {
    mkdir -p "$1"
    cd "$1"
}

```
2.bash shell以空白做分割，所以中間不要有空白
3. bash語言中很多特殊符號，可以參考[這裡](https://www.tldp.org/LDP/abs/html/special-chars.html)
4. 一隻會查找給予的檔案(arguments)中有沒有包含`foobar`，沒有就會加進去到檔案最後一行的一隻script
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
   Wildcard - `ls *.py`, `rm foo*`
   Curly braces`{}` - 表示或, `ls *.{py,sh}`

```
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
  * command --help
  * man --help
  * stackoverflow
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

* 以下指令需要下載一些新的指令激，像是`ack`, `ag`, `rg`，這些指令集都非常好用，有需要的話可以使用
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
搭配一下想找的指令，`history | grep find`
* 另一個很酷的東西，講師自己非常喜歡的則是`history-based autosuggestions`，首先介紹一下[`fish`](https://fishshell.com/) shell, [fish-shell github](https://github.com/fish-shell/fish-shell)，這個東西可以在你的[zsh](https://asciinema.org/a/37390)中
* 其中一點要注意的是，這樣的工具會紀錄你輸入過的東西，所以像是一些敏感資訊，要把它們拿掉，這可以從`.bash_history`或是`.zhistory`中調整


## 資料夾導航
* 可以透過`ln -s`，快速連結到某個資料夾，但是必須在該檔案中設定一個檔案，並對其更改權限
* 直接列出資料夾結構 `tree`,`broot`
* 非常優秀的檔案管理`nnn`, `ranfger`

## Exercise
* took 90 mins

https://missing.csail.mit.edu/2020/shell-tools/