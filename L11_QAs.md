# 哪些工具是講師會優先學習?
* 以下是幾個優先順位
* 多用鍵盤，少用滑鼠 - 省時間
* 學習你的編輯器(VSCode, Vim, ... and so on) - again, 操作時省時間
* 學習讓重複工作自動化 - 省下的時間會非常巨大...
* 版控工具 - 避免自己手殘刪掉東西可以checkout回去，可建立自己的程式庫，以及能夠和其他設計師協同工作

* [WebPage](https://missing.csail.mit.edu/2020/qa/)

# 我們的package到底都裝在哪裡，還有`/bin, /lib`到底是啥?
* 所有可以在你terminal執行的指令，一錠都會在`PATH`裡面，你可以用`which`找到他們被執行的地方，linux得這些內容在[這裡](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)有更詳細的描述，這裡我們列出一些
*`bin` : Essential command binaries : 一些必要的二進位檔
*`sbin` : Essential system binaries, usually to be run by root，一些必要的二進位檔， 但是要是super root
* `dev` : device files, often are interfaces to hardwrare devices
* `etc` : Host-specific system-wide configuration files : 壹些設定檔，特別是跟系統有關，跟user有關的
* `lib` : common libraries for system programs - 系統所需要的套件
* `opt` : optional application software - 對於系統來說，一些選用軟體
* `sys` : 系統設定檔，但是並非和user有關
* `tmp` : 暫時檔案，`/var/tmp`之下的也是，每次重開機就洗掉了
* `usr` : 只可讀取的user檔案
  * `usr/bin` : 二進位檔
  * `usr/sbin` : 只能用super user讀取的二進位檔
  * `usr/local/bin` : user自己compile之後的二進位檔
* `var` : 變數檔案，像是日誌(logs)或是緩存(caches)

# More Vim tips

# Any tops or tricks for Machine Learning applications?