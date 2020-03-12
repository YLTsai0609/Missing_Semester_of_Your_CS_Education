# Intro
寫英文和寫程式是非常不一樣的兩種行為，寫程式時，你的時間花在轉換檔案，讀檔案，搬移檔案，編輯程式碼，看著別的程式碼修改自己的程式碼等，說寫英文字和寫程式是不同的行為是非常合理的

身為程式設計師，我們大部分的時間花在編輯程式碼，如此一來非常值得投資一個為此設計的編輯器，這裡就教你怎麼學習一個新的編輯器

1. 從教學文件(本文)
2. 使用該編輯器，即使很不熟
3. 邊學邊看

預期你應該會在學習並且操作20個小時之後，達成跟舊的編輯器依樣的操作速度甚至更快，如此一來依舊可以學更多東西

VSCode is the most popular editor
Vim is the most popular command-line-based editor

# Vim
所有的課程講師都使用Vim，Vim有著豐富的歷史，他是Vi的變形(1976)，而至今他都一直還在發展中，Vim的發展中有一些關鍵的idea，在這個理由下，大部分的工具都支援vim模式，甚至有1千400萬人的vscode都走安裝Vim熱鍵，Vim可能是最值得學習的文字編輯器，甚至你已經學了其他的編輯器

不可能在50分鐘之內教你所有的Vim功能，所以我們會跟你解釋Vim的哲學，以及基本，展示給你看一些更進階的功能，最後給你資源

# Vim的哲學
當你在寫程式時，最花時間的其實是閱讀跟編輯，而不是書寫，在這個理由下，Vim是一個modal editor，他針對插入文字和操作文字有不一樣的模式，Vim is programming language(with Vimscript and also other languages like Python)，Vim本身的介面寄售一個程式語言，你所敲擊的按鈕就是command，而這些command是可被組合的，Vim避免使用滑鼠，因為太慢了，甚至不想要使用到箭頭按鈕，因為它們太遠了

所以在熟悉的情況下，使用編輯器的產出就跟你的想法一樣快

# Modal Editing
Vim 的設計是想要解決程式設計師的時間，包含讀文件，文件間跳轉，做一些編輯，這些事情和打字不同，在這個理由之下，Vim有多種操作模式

* **Normal** : 在一個file中移動及編輯
* **Insert** : 插入文字
* **Replace** : 變更文字
* **Visual** : 選取一大隊文熾
* **Command-line** : 跑一些command

在每個模式下，鍵盤上的按鍵都有不同的意思，比如說，按下`x`在**insert model**會插入一個`x`，在**normal model**下，他會把游標下cover的字刪除，在**visual model**中，則會把選取到的東西刪除

在預設的組態下，Vim會把目前的模式顯示在底部左端，inital/default會是normal mode，通常來說你會花時間在normal model以及insert model之間

`Esc` : any to normal, `Esc` means Escape

`i` : any to insert

`r` : any to replace

`v` : any to visual

`Crtl + V` : visual block

`:` command-line mode

`help w` : help for `w`

`help :w` : help for `:w`

# Basics

`i` : insert text

`:` : help q - show出q的說明

`:y` : 複製單行

`:p` : 貼上單行

buffers, tabs, and windows
Vim會維護一塊開啟的檔案，稱作buffers，一個vim session會有幾個tab(就會網頁編輯器那樣)，就向sublime text, vscode那樣，都有tab可用

在Vim裡面比較不同的是，tab裡面還有window，這在vscode和sublime裡面是不同的
在開啟一個window `sp` - split current wondow in two，這其實只是兩個不同的視角，但是是同個檔案，而windows會存在同個檔案buffer中，這在觀看同個檔案的不同地方時很實用
    * normal mode之下 `w`會移動一個字，`crtl + w` 會在splits之間移動

`tabnew`會展開一個新的tab

    * command line 移動tab : `tabn` : for next tab, `tabp` for previous tan

`q` : 離開當前window，所以如果你有三個window，那你要`q`三次
`qa!` : 全部關掉不儲存
`xa` : 全部儲存且關閉

# Vim's interface is a programming language!
* in mormal mode
## Movement
* **hjkl** : (left, down, up, right)
* **Words** : `w` : next word head, `b` back word head, `e` next word end
* **Lines** `0` : 一列的頭，`$` : 一列的尾
* **Scroll** : `crtl+U` up, `crtl+D`  down
* **Screen**: H (top of screen), M (middle of screen), L (bottom of screen) (必須是大寫)
* **File**: gg (beginning of file), G (end of file)
* **Find**: f{character}, t{character}, F{character}, T{character}
            find/to forward/backward {character} on the current line
            , / ; for navigating matches 
            Search: /{regex}, n / N for navigating matches
## Edit
* `i` : insert
* `o/O` : 向下插入一行，向上插入一行
* `d` : delete, 刪除是一個組合技，`dw`刪除字, `db`刪除前一個字, `de`到該字的最後, `dd`刪除一行，`d0`刪除到頭，`d$`刪除到尾
* `u` : undo
* `ctrl + R` redo
* `c` : change, 改字，也是一個組合技，跟`d`一樣，他會做到刪除，然後幫你進入到insert mode，非常常用，`cc`會刪掉這行然後進入insert mode
* `x` : 刪除單個字元(和`dl`一樣)
* `r` : 修改單個字元，組合技 `ra`將選到的字元改成`a`
* `y` : copy, 同樣地，這也是一個組合技，如同上面`d`以及`c`一樣來使用, copy可以搭配選取來使用，所以我們要進入到Visual Mode
* `p` : paste
* 編輯還有很多fancy的地方，例如visual select line + `~`全部換成大寫等等，這些可以自己查跟練習

## Selection
* `Visual` : `v`進入visual mode，接著就可以hjkl來選取，或是上下左右，或是觸控板，然後`y`，就會顯示已經複製，並且幫你回到normal mode
* `Visual line` : `V` : 一次選一行
* `Visual Block` : `ctrl + V` : 一次選一塊

## Counts
* 數字可以搭配任何command來使用
* `3w` 往前走3個字
* `5j` 往下走5行
* `7dw` 刪除7個字

## Modifers
這可以搭配特殊符號，在有特別的框框中使用效果特別好，
`i` : inner
`a` : around
`%` : 在特殊符號中跳轉，包括`[]`, `()`, `''`
`ci[`, `ci(`, `ci'` 可以在[], (), ``, 裡面修改
這些modifers可以搭配`c`, `d`, `y`, `p`等等command

# demo time
幾個重點
1. 善用gg, G, word, back跳轉
2. 用/搜尋
3. .可以重複貼上上一個命令

# Costum Vim
[TODO 42, 48](https://missing.csail.mit.edu/2020/editors/)

# additinal matirials
[Why I love Vim: It’s the lesser-known features that make it so amazing](https://www.freecodecamp.org/news/learn-linux-vim-basic-features-19134461ab85/)


