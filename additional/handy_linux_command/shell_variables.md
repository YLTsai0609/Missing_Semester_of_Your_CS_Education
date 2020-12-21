
# 變數
* 動機 : 每次都被，環境變數/路徑 PATH搞得很煩，要來好好了解一下變數，進而提供可操作性
* 概念 : 當輸入`mail`這個指令時，如果你是root, 則會執行 `var/spool/mail/root`，當你是vbird，則會執行 `/var/spool/mail/vbird`
  如此一來，一個變數，通吃所有user，不用把執行路徑寫死，這樣的概念用在所有可被呼叫的指令中，像是`ls`, `cat`, ...等所有指令
  同樣的道理，不只可以用在系統預設上，進行開發時，也可以利用bash的變數，來處理每台電腦都不一樣的路徑問題!

* 變數取用 `echo $HOME` or `echo${HOME}`
* 變數賦值 
```
[dmtsai@study ~]$ echo ${myname}
       <==這裡並沒有任何資料～因為這個變數尚未被設定！是空的！
[dmtsai@study ~]$ myname=VBird
[dmtsai@study ~]$ echo ${myname}
VBird  <==出現了！因為這個變數已經被設定了！
```
* 變數給值規則
1. 有些shell中echo空的變數會是空的，有些則會噴error，要注意
2. 不能有空白字元 myname = VBird 會噴錯
3. 變數名稱只能是英文字母和數字，但**開頭不能是數字**，例如`2nyname=VBird`會噴錯
4. 變數內容需要空白字元，可以使用`"`或是`'`
   * **雙引號內的特殊字元，可以保有原本特性**，例如 `var="lang is $LANG"` -> `echo ${var}` 可以得到  lang is zh_TW.UTF-8
   * **單引號內的特殊字元，則僅為純文字**，例如 `var="lang is $LANG"` -> `echo ${var}` 可以得到  lang is $LANG
5. 可用跳脫字元`\`將特殊符號變成一般字元，例如 `myname=VBird\ Tsai` 
6. 一串指令中需要藉由其他指令提供的資訊，除了使用`$`還可以使用反向單引號，例如 `version=$(uname -r)` -> `echo $version` 可以得到 3.10.0-229.el7.x86_64
7. 如果想要累加變數(擴增變數內容)，可以這樣子，以PATH舉例 : `PATH=${PATH}:/home/bin`，再一個例子 : `version=${version}MacAir`
8. 若該變數需要在其他子程序執行，則需要`exoport`來使變數變成環境變數，例如 : `export PATH`
9. 通常大寫字元為系統預設變數，自行設定變數可以使用小寫，方便判斷(純粹依照使用者興趣)
10. 取消變數的方法 : `unset`，例如 `unset myname`
11. 遇到設定變數榮需要`'`，用雙引號包起來 : `name="VBird's name"`
12. 將自訂變數用在路徑上
```
d=pandas_101
echo ${d} # for check the variable
cd ~/Desktop/${d} # worked!
```

## 環境變數
變數當中，被linux系統預設能夠使用的，稱為環境變數，可以幫助我們完成**家目錄變換**，**提示字元顯示**，**執行檔搜尋的路徑**等等
* `env` 列出目前shell環境下的所有環境變數以及變數內容

|變數|值|
|---|--|
|HOSTNAME|study.centos.vbird|
|TERM|xterm|
|SHELL|/bin/bash|
|USER|dmtsai|
|HITSIZE|1000 指的是系統會記錄過去的1000個命令|
|PATH|執行黨的搜尋路徑，就是我們所謂的環境變數，目錄和目錄之間用冒號分隔，由於檔案的巡雲是依序由PATH目錄來查詢，所以目錄的順序也很重要喔|
|HOME|/Users/yltsai 也就是家目錄|
|LANG|語系資料，對我們來說通常是zh_TW.UTF-8或是 zh_TW.Big5|
|_|/usr/bin/env 上一次使用的指令的最後一個參數|

* `set` 列出所有變數，包含環境變數與自訂變數
例如我們自己設的變數

* 不論是否為環境變數，只要跟我們目前這個shell操作介面有關的變數，通常會被設成大寫

* 重要的 shell 變數
  * PS1(數字的1)，這個東西就是命令提示字元，每次按下[Enter]執行某個指令後，最後要再次出現提示字元時，就會主動讀取這個變數值，可以man bash查詢一下PS1的相關說明
  * 錢字號 關於本shell的PID，錢字號本身也是個變數，這個東東代表的是**目前這個shell的執行緒代號**
  * 可以透過 `$$`來顯示PID號碼
  * ? (關於上個執行指令的回傳值)，沒錯，問號也是一個特殊變數，這個變數指的是**上一個執行的指令所回傳的值**，上面這句話的重點是**上一個指令**和**回傳值**兩個地方，當指令執行成功時，指令代碼會回傳0，如果執行過程發生錯誤，會回傳錯誤代碼，一般來說就是非0的值
  ```
  echo $SHELL
  echo $? -> 0 # 沒問題，所以顯示0
  12name=VBird
  echo $? -> 127 # 因為有問題，回傳錯誤代碼
  echo $? -> 0 # 因為上一個指令 echo $?是正確指令，所以回傳0
  ```
* `export` 自訂變數轉成環境變數
  自訂變數與環境變數的差異在在於**該變數是否會被子程序繼續引用**
  <img src='/images/bash_variable_1.png'></img>
  * 我們在原本的bash底下執行另一個bash，那原本的bash就會睡著(父程序)，我們開啟的另一個bash則稱為子程序
  * **子程序僅會繼承父程序的環境變數，子程序不會繼承父成數的自訂變數!**
  * export可以將變數輸出，讓父程序可以使用!

### 加入環境變數
1. 先確認該檔案存在在你的系統中，這裡舉例mysql
`ls /usr/local/mysql/bin/mysql` - 確認執行檔存在
2. 進入.bashrc, .bash_profile
```
# MySQL path variable
mysql_path=/usr/local/mysql/bin/
export PATH=$PATH:mysql_path
```

3. source .bashrc, .bash_profile

4. echo $PATH - 確認路徑是否存在

5. 呼叫指令，應該要呼叫到該執行檔, 例如呼叫 mysql


# 變數鍵盤讀取、陣列和宣告 : read, array, declare
* `read`, `declare`, `typeset`, `array`
pass

# 變數內容的刪除、取代和替換
pass

# 命令別名設定 : alias, unalias
* 動機 : 常常使用 `ls-al | more` 來看檔案，可是每次都要打這麼多字，覺得很煩
* `alias lm='ls -al | more'`，會立刻多出一個可執行的指令`lm`
* alias的定義與變數定義規則幾乎相同，所以要輸入指令時要以純文字，因此要加單引號，如果加雙引號，後面內容會是變數名稱喔
* 取代原本的rm `alias rm='rm -i'`，因為總會有手殘誤刪的時候
* 怎麼查現在有哪些alias? `alias`
```
alias

alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias grep='grep --color'
alias ls='ls -F --show-control-chars --color=auto'
# 可以看到我們透過alias來設定一些顯示的顏色
```

# 萬用字元與特殊符號

|符號|意義|備註|
|---|----|---|
|*|代表0個到無窮多個|從regax抄來的|
|?|代表一定有一個|從regax抄來的|
|[]|代表一定有一個在[]裡面，例如[abcd]代表一定有一在字元，可能是a,b,c,d任何一個|從regax抄來的|
|[-]|連續字元, 例如[0-9], [A-Z]|從regax抄來的|
|[^]|反向選擇，[^abc]找一個字元，非abc|從regax抄來的|
|#|註解符號，用在script中||
|\|跳脫符號，將特殊字元或萬用字元還原成一般字元||
|**|**|管線符號||
|;|連續下達指令 : 連續性命令，和管線符號並不相同||
|~|家目錄||
|$|取用變數的前置字元||
|&|將指令變成背景工作||
|!|not||
|>, >>|資料流重定向, 取代, 累加||
|<, <<|資料流重定向||
|''|單引號，不具有變數置換的功能，內容變成純文字||
|""|具有變數置換的功能，可保留相關功能||
|``|等同於$()，表示先做裡面的命令||
|()|子shell的起始和結束，先做的意思||
|{}|命令區塊的組合||

## 命令執行的判斷依據 : ; && ||

|指令|舉例|說明|
|----|--|----|
|cmd1; cmd2; cmd3|sync; sync; shotdown -h now|先執行兩次sync同步寫入磁碟，然後關機，輸出的commend有前後依賴關係時|
|cmd1 && cmd2|ls /tmp/abbc && touch /tmp/abc/hehe| ls指令執行完畢而且正確執行($?=0)，則開始執行cm2，cmd1執行完畢且為錯誤($?!=0)，則cmd2不執行|
|cmd1 || cmd2|ls /tmp/abbc && touch /tmp/abc/hehe| 和上面一個反過來|

linux命令是由左至右的，所以`&&`和`||`的位置不要放反喔!







































