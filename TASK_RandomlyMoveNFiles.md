# Background
* 隨機移動N個檔案從raw data folder到inlabelled data folder，但是又不想寫python script，bash能不能再兩三行之內搞定?
* 在train/val/test中的每一個target，按照hololens以及phone進行分組，分成3個fold進行標注作業，這算是一種分組，需要用到`迴圈`，`路徑`，`代數運算`

* [How to move a given number of random files on Unix/Linux OS
](https://stackoverflow.com/questions/14033129/how-to-move-a-given-number-of-random-files-on-unix-linux-os)
    * 使用shuf, xargs, ls, mv 以及pipe功能

* [Install shuf on OS X?](https://apple.stackexchange.com/questions/142860/install-shuf-on-os-x)
  * linked with gshuf
* [xargs](https://www.runoob.com/linux/linux-comm-xargs.html)
  * linux才支持{}操作

# Experiements

check `RandomlyMoveFileExp`