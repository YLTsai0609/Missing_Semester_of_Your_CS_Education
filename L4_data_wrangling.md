# L4 Data Wrangling
你曾經想要將資料從一個類型轉換成另一個不同的類型嗎? 妳一訂有的，而且這件事還非常常發生，這就是這堂課想要教的，這堂課會講特別多，不管是文字資料還是二進位資料!

我們已經有做過一些簡單的資料整理，通常你有用到pipe `|`的時候就是在做某些資料處理，不過這邊我們做更細節的介紹

我們馬上來看一個例子，我想知道誰登入了我的server，藉由觀看我server的log來得知

```
ssh myserver journalctl | grep sshd
```
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

# `sed`

`sed`指的是stream editor, 所以如果你想要更改檔案的話，除了直接對檔案做更改，你也可以使用`sed`

簡單的使用方式是這樣

`sed 's/md/py/g'` : s -> 取代, 把md換成py, globally
`sed 's/md//g'`  : s -> 取代, 把md換成空白, globally

換成空白很常用，讓我們看畫面的時候可以乾淨一點，萬用字元`*, ., ? [0-9], [a-z][A-Z]`都是能用的

透過`sed`可以直接修改檔案內容，vim中也能夠使用，透過add來進行操作

[TODO 0903](https://missing.csail.mit.edu/2020/data-wrangling/)