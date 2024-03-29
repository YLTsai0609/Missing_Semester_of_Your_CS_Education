# L4 Data Wrangling

你曾經想要將資料從一個類型轉換成另一個不同的類型嗎? 你一定有的，而且這件事還非常常發生，這就是這堂課想要教的，這堂課會講特別多，不管是文字資料，圖片資料，還是二進位資料，當我們有一個任意的資料格式(log, text, image)，要整理成自己想要的樣子(圖表，按照檔案大小排序等)，我們就把它稱為data warangling.

我們已經有做過一些簡單的資料整理，通常你有用到pipe `|` 的時候就是在做某些資料處理，不過這邊我們做更細節的介紹

# Text

## `grep`

我們馬上來看一個例子，我想知道誰登入了我的server，藉由觀看我server的log來得知

``` 

ssh myserver journalctl | grep ssh
```

`journalctl` 可以讓我們查到系統的log，尤其是那種很多人都可以登入進到server做事情的機器，你可能會產生這種需求來了解其他人在server上都在幹嘛

其實你可以一直串連下去

``` 

ssh myserver 'journalctl | grep sshd | grep "Disconnected from"' | less
```

你也可以這麼做

``` 

ls | grep "md" | grep "L4" | less
```

你可能還是會遇到很多很阿雜的東西，那麼你可以這麼做

``` 

ssh myserver journalctl
 | grep sshd
 | grep "Disconnected from"
 | sed 's/.*Disconnected from //'
```

`grep` 也可以搭配正則表達式，例如每次 `ifconfig` 都找自己的ip找很久

 `ifconfig | grep -E '([0-9]{1,3}\.?){4}'`

即 ifconfig 並使用正則表達式 ([0-9]{1, 3}\.?)共找出4個，並grep出來

## `ag`

`brew install ag`

`ag` - 更強大，更好用，更直覺的 `grep`

```

  ag

  The Silver Searcher. Like ack, but aims to be faster.
  More information: https://github.com/ggreer/the_silver_searcher.

  - Find files containing "foo", and print the line matches in context:
    ag foo

  - Find files containing "foo" in a specific directory:
    ag foo path/to/directory

  - Find files containing "foo", but only list the filenames:
    ag -l foo

  - Find files containing "FOO" case-insensitively, and print only the match, rather than the whole line:
    ag -i -o FOO

  - Find "foo" in files with a name matching "bar":
    ag foo -G bar

  - Find files whose contents match a regular expression:
    ag '^ba(r|z)$'

  - Find files with a name matching "foo":
    ag -g foo
```

## `sed`

`sed` 指的是stream editor, 所以如果你想要更改檔案的話，除了直接對檔案做更改，你也可以使用 `sed`

簡單的使用方式是這樣

`sed 's/md/py/g'` : s -> 取代, 把md換成py, globally
`sed 's/md//g'` : s -> 取代, 把md換成空白, globally

換成空白很常用，讓我們看畫面的時候可以乾淨一點，萬用字元 `*, ., ? [0-9], [a-z][A-Z]` 都是能用的，所有的regax
透過 `sed` 可以直接修改檔案內容，vim中也能夠使用，透過 `s` 來進行操作
反轉譯，使用 `\\` ，例如 `\(ab\)` -> `(ab)`

### Some popular Regular expressions

* `.` 任何單一字元，除了新的一列
* `*` 0個或是多個match
* `+` 1個或是多個match
* `[abc]` 任何match a, b, c的字元
* `(abc)` 任何連著abc的字元
* `(RX1|RX2)` 任何RX1 或是 RX2 match
* `^` match 開頭 - 當我們需要compelete match時，通常會需要 `^` ,           `$`
* `$` match 結尾
* `()` group : match之後但想要保留，例如想知道有誰login server
* **sed**中使用regax時，要將符號反轉譯，或是加上 `-E`
* [regax debugger](https://regex101.com/r/qqbZqh/2)
* 關於regax有很多討論，像是怎麼抓email，或是確認質數等等，有很多用途
* [這裡的整理甚至是處理了幾組有效的url應該會有隱樣的regax](https://mathiasbynens.be/demo/url-regex)

### Other useful functionality (I)

* `wc` wourd count, 同樣也是非常的一個工具，拿來計算說資料有多少(可以計算字元數，行數，byte數等)
* 當你需要計數時，在bash環境下，不要想迴圈，想到wc，會節省你一大堆時間
* `sort` 可以排序，像是按照a-z, 0-9, 或是按照資料夾 `-d` ，按照月份 `-M` ，反轉 `-r` 等等
* `uniq` 可以計算獨立值，只顯示獨立值，可以加上 `-c` 來使用value counts，或是其他configuration

在這樣的使用下，可以從登入log中找出最常登入的user，這裡舉例檔案查找，隨便把一堆command疊在一起

``` 

locate site-package | grep "python3.7" | sed -E 's/.*site-package//g' | sort | uniq -c | wc -l
```

## `awk`

* `awk` 是一個column based steam editor， `awk` 是一個行操作，具有 `sed` 的所有功能，但是更為強大，其實也是一個程式語言XD，這個指令對於text stream的處理非常在行，現在我們學幾個常用的

**pass this part**
**back if needed**

## Other useful functionality (II)

* `paste` 貼上，但是轉換一下格式，例如 `ls | paste - - -` : 用3行貼上
* `bc` : caculator
* `R` : 可以直接把terminal的東西用R計算統計分佈
* `gnuplot` : 可以直接把terminal的東西用R畫圖
* `xargs` : 把input變成arguments - 可以把東西列出來，然後讓程式去執行當作arguments
* `tee` : 可以當作中介
* [ `convert` ](https://www.howtogeek.com/109369/how-to-quickly-resize-convert-modify-images-from-the-linux-terminal/) : 可以作檔案類型轉換 "resize", "convert" and "modify" multiple images, mac上不好裝, ubuntu預設有
  + 用convert做圖片的batch Processing應該會超快，例如 : 把所有png檔案轉90度，可以想像後面可以接上轉乘jpg, 灰階, 套用一些效果，然後壓縮，傳到遠端，可以用一行
  + `for file in *.png; do convert $file -rotate 90 rotated-$file; done`
* 同時也可以直接建立streamming `cat /dev/video0 ssh xxxxx`

## JSON data(specialize text)

json 格式的資料在企業中很常見，經常以一種資料交換的格式出現

`jq` json processor 就是讓你在 terminal 中，做各種輕量的json處理，包含 access by key, asccess the eleement, ...

`pip install jq`, `brew install jq`

https://stedolan.github.io/jq/manual/#Invokingjq

```
  jq

  A command-line JSON processor that uses a domain-specific language.
  More information: https://stedolan.github.io/jq.

  - Output a JSON file, in pretty-print format:
    jq . file.json

  - Output all elements from arrays (or all the values from objects) in a JSON file:
    jq '.[]' file.json

  - Read JSON objects from a file into an array, and output it (inverse of `jq .[]`):
    jq --slurp . file.json

  - Output the first element in a JSON file:
    jq '.[0]' file.json

  - Output the value of a given key of each element in a JSON text from stdin:
    cat file.json | jq 'map(.key_name)'

  - Output the value of multiple keys as a new JSON object (assuming the input JSON has the keys `key_name` and `other_key_name`):
    cat file.json | jq '{my_new_key: .key_name, my_other_key: .other_key_name}'

  - Combine multiple filters:
    cat file.json | jq 'unique | sort | reverse'

  - Output the value of a given key to a string (and disable JSON output):
    cat file.json | jq --raw-output '"some text: \(.key_name)"'
```


## Binary data (image, sound, ...)

* `ffmpeg` : encode and decode the video and operate on images

* 從video0裝置抓取frame，轉成灰階, 壓縮, 然後傳到遠端機器上

``` 

ffmpeg -loglevel panic -i /dev/video0 -frames 1 -f image2 -
 | convert - -colorspace gray -
 | gzip
 | ssh mymachine 'gzip -d | tee copy.jpg | env DISPLAY=:0 feh -'
```

* port forwarding with `X11`
  + `ssh -XY uname@ip`
  + [X11 Forwarding in SSH: connection rejected because of wrong authentication](https://www.ibm.com/support/pages/x11-forwarding-ssh-connection-rejected-because-wrong-authentication)

## Exercise 

[check](https://missing.csail.mit.edu/2020/data-wrangling/)

* 可以透過 `log show` 來查看system log，最好先help一下，不然就只是terminal爆噴log

## Additional matirials

* [Perform arithmetic operations](https://bash.cyberciti.biz/guide/Perform_arithmetic_operations?fbclid=IwAR3xgOhDid0CbkPqogoghOaTAm087JVwBycgg4PzaeOTuehPGk8x0UeOBVY)
* [xargs, take stdout as argument, check `RandomlyMoveFileExp` ](RandomlyMoveFileExp/stratified_sampling_by_file_name.sh)

### arithmetic operations

``` 

$((expression))
$(( n1+n2 ))
$(( n1/n2 ))
$(( n1-n2 ))

equal to 
$[$a+$b]
```
