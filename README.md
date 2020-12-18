# The Missing Semester of Your CS Education

* MIT(麻省理工學院)短期課程，轉職CS必修課!
* [連載Blog from someone](https://blog.gslin.org/archives/2020/02/15/9408/mit-%E7%9A%84%E3%80%8Cthe-missing-semester-of-your-cs-education%E3%80%8D/)
* [知名Facebook粉專 - Learning By Hacking轉發，170+分享](https://www.facebook.com/datasci.info/photos/a.379757428885161/1217568378437391/?type=3&theater)
* 來自Hacker News上的網友回應:

``` 

Sure, some stuff you learn in CS can make you a better software engineer. CS cannot make you a software engineer.

CS can definitely not make you adept at using computers and neither should it. That’s something earlier education institutions must tackle.

It’s always good to have optional courses for various topics of interest. _Requiring_ students to learn, say, MS Office (I had to), is just plain ridiculous.
```

* 11堂課大部分圍繞在Command line enviroment，working on remote machine, version control, finding files, Text Editing, data wrangling and security!
* 去年課程**Hacker Tools**更包含了Vitual Machine and Containers, Backups, Automation, OS Customization, and Remote Machine!
* [Check the WebPage](https://missing.csail.mit.edu/?fbclid=IwAR2qc-p56sO7I4XDE3Bmc09TLEZ0lWvDrrOOHWkTPWbfqD0X5KsXghuiXz4)

# Schedule

| Section | Compelete | Note  |
|---------|-----------|-------|
| 1 Course overview + the shell  | 12/13, 20     |  |
|2  Shell Tools and Scripting      |12/13, 20      ||
|3 1/15: Editors (Vim)|12/13, 20||
|4 1/16: Data Wrangling|12/13, 20||
|5 1/21: Command-line Environment |12/13, 20||
|6 1/22: Version Control (Git)|12/13, 20|
|7 1/23: Debugging and Profiling |||
|8 1/27: Metaprogramming|||
|9 1/28: Security and Cryptography|||
|10 1/29: Potpourri|||
|1/30: Q&A|||

# Why we are teaching this class

During a traditional Computer Science education, chances are you will take plenty of classes that teach you advanced topics within CS, everything from Operating Systems to Programming Languages to Machine Learning. But at many institutions there is one essential topic that is rarely covered and is instead left for students to pick up on their own: computing ecosystem literacy.

Over the years, we have helped teach several classes at MIT, and over and over we have seen that many students have limited knowledge of the tools available to them. Computers were built to automate manual tasks, yet students often perform repetitive tasks by hand or fail to take full advantage of powerful tools such as version control and text editors. In the best case, this results in inefficiencies and wasted time; in the worst case, it results in issues like data loss or inability to complete certain tasks.

These topics are not taught as part of the university curriculum: students are never shown how to use these tools, or at least not how to use them efficiently, and thus waste time and effort on tasks that should be simple. The standard CS curriculum is missing critical topics about the computing ecosystem that could make students’ lives significantly easier.

# Update your Bash

在我的Mac上，bash版本是3.x版，2007年出的，主要需要更新的原因是vscode的Bash Debug extension，只支持4.0以上的版本

 `brew install bash`

# More About MIT

[麻省到底是哪個省，麻省理工到底有多強](https://kknews.cc/zh-tw/history/zgkbr93.html)

# Addtional Content

## Vim - tutorial

| Section and Content | Complete | Note  |
|---------|----------|-------|
| L1 vi/vim modes in vim   | 12/13    | if you are not familar with vim, check L3 Editors Vim instead |
| L2 navigation   | 12/13    | |
| L3 inserting text   | 12/13    |  |
| L4 deleteing text   | 12/13    |  |
| Bonus vim wondows   |     | |
| Bonus vim combinations   |     | |
| Bonus vim search, find, and replace   |     | |
| Bonus tmux   | 12/13    | |
| Bonus tmux   | 12/18    | |

## Handy Linux conmmand and concepts

Incliuding:

[handy_linux_command](additional/handy_linux_command.md)

1. Network(ifconfig, socket, ping, nmap, scp, curl, fix ip and floating ip, loopback ip, iwconfig, dns, ssh)
2. backup, packing, unpacking(dd, gzip, zip, unzip, tar)
3. shell script(why we need shell script, if else, variables, env vsariables)
04. alias unaluas
05. history
6. wildcard(bash萬用字元，和regax有點像)
07. pipe, cut, grep
8. data redirection(stdout, stderr, stdin, tee, :, &&)
9. job control(nohup, ctrl + z, bg, fg, kill, wait)
10. file profiling(cat, less, head, tail, echo)
11. system profiling(top, htop, df -h, uname -a, w, whoami, free)
12. find a file/directory(find, locate, whereis, which)
13. package management(masOS(brew, flnk), Ubuntu, Debian(apt, dpkg), curl, wget)
14. filesystem structure
15. kernel management(ukuu)
16. memory and device management(lscpu, nvidia-smi)
17. command line short-cut

# Reference

* [跟著阿明學Linux - 實體書](https://www.books.com.tw/products/0010796234)
* [鳥哥的 Linux 私房菜 - Linux基礎訓練](http://linux.vbird.org/linux_basic_train/)
* [Vim section of Coding Interview University](https://github.com/jwasham/coding-interview-university/blob/master/translations/README-tw.md#emacs-and-vim)
* [Vim cheat sheet](https://vim.rtorr.com/lang/en_us)
* [Vim分割視窗](https://2formosa.blogspot.com/2016/07/vim-split-window.html)
* [Vim documentation](https://www.vim.org/docs.php)
* [modes in vim](https://irian.to/blogs/introduction-to-vim-modes/)
