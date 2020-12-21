# 一些想透過bash script完成的任務

1. [90%]自動化備份 `.bash_profile`,    `.vimrc`,    `settings.json`,    `condarc` in vscode and vscode-insider等等設定，以便於災難救援或是創建新User。
2. 了解怎麼把現在所在路徑縮短，包含

   * 了解bash是取用哪個變數來顯示
   * 怎麼縮短
   * 怎麼找到當前縮短的值?

3. 搞定brew權限，然後升級bash，版本太舊 vscode debugger 不支援
4. 掌控Vim，降低連server有時候無法VSCode的痛苦

# complete

1. [最後使用了Python...]能否寫個bash，輸入當前的abc_2.png，那把桌面上所有`螢幕截圖 日期`，排序，然後依序命名成`abc_3.png`,    `abc_4.png`,    `abc_5.png`, ... 
2. 資料切分(Cross validation)

## Task background

* 隨機移動N個檔案從raw data folder到inlabelled data folder，但是又不想寫python script，bash能不能再兩三行之內搞定?
* 在train/val/test中的每一個target，按照hololens以及phone進行分組，分成3個fold進行標注作業，這算是一種分組，需要用到`迴圈`，`路徑`，`代數運算`

* [How to move a given number of random files on Unix/Linux OS

](https://stackoverflow.com/questions/14033129/how-to-move-a-given-number-of-random-files-on-unix-linux-os)

    - 使用shuf, xargs, ls, mv 以及pipe功能

* [Install shuf on OS X?](https://apple.stackexchange.com/questions/142860/install-shuf-on-os-x)
  + linked with gshuf
* [xargs](https://www.runoob.com/linux/linux-comm-xargs.html)
  + linux才支持{}操作

# 補充資料

* 針對自動備份 : 

   * 設定github ssh，每次都透過https還要輸入帳密，麻煩
   * [使用 SSH 金鑰與 GitHub 連線](https://andy6804tw.github.io/2018/03/22/github-ssh/)
   * [Git教學：如何 Push 上傳到 GitHub？, check for ssh](https://gitbook.tw/chapters/github/push-to-github.html)
   * [Automatically push an updated file whenever it is changed](https://gist.github.com/darencard/5d42319abcb6ec32bebf6a00ecf99e86)
