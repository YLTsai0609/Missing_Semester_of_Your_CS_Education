# 一些想透過bash script完成的任務

1. [90%]自動化備份 `.bash_profile`,  `.vimrc`,  `settings.json`,  `condarc` in vscode and vscode-insider等等設定，以便於災難救援或是創建新User。
2. 了解怎麼把現在所在路徑縮短，包含

   * 了解bash是取用哪個變數來顯示
   * 怎麼縮短
   * 怎麼找到當前縮短的值?

3. 搞定brew權限，然後升級bash，版本太舊 vscode debugger 不支援
4. 掌控Vim，降低連server有時候無法VSCode的痛苦

# complete

1. [最後使用了Python...]能否寫個bash，輸入當前的abc_2.png，那把桌面上所有`螢幕截圖 日期`，排序，然後依序命名成`abc_3.png`,  `abc_4.png`,  `abc_5.png`, ... 

# 補充資料

* 針對自動備份 : 

   * 設定github ssh，每次都透過https還要輸入帳密，麻煩
   * [使用 SSH 金鑰與 GitHub 連線](https://andy6804tw.github.io/2018/03/22/github-ssh/)
   * [Git教學：如何 Push 上傳到 GitHub？, check for ssh](https://gitbook.tw/chapters/github/push-to-github.html)
   * [Automatically push an updated file whenever it is changed](https://gist.github.com/darencard/5d42319abcb6ec32bebf6a00ecf99e86)
