# Ref

[你一定用過 htop，但你有看懂每個欄位嗎？](https://medium.com/starbugs/do-you-understand-htop-ffb72b3d5629)


# CPU

1. htop的CPU顯示的是邏輯核心數 - 如果你的電腦是4核心8執行緒，意思是同時可以執行8個Thread，那麼htop就會顯示8個CPU
2. 紅色 - kernel thread 佔用 (系統自動做的 process shceduling, memory management) - 系統中最重要，優先權也最高
3. 綠色 normal priority thread (一般來說使用者執行的程式沒有特別調整優先權的話，會歸在這一類)
4. 藍色 low priority thread (我ok、你先跑 那類比較無關緊要的Process)，如果CPU已經被操到快不行了，或是memory真的不夠用了，第一個殺掉的也是這一類process

# Memory & Swap

## Memory 顏色
1. 綠色 - process 佔用記憶體 (你開的瀏覽器、VSCode、終端機、正在執行的htop)
2. 藍色 - buffer pages (儲存meta data)
   1. 例如 `ls -l` 時，系統會去硬碟撈撈看資料夾有哪些檔案，以及權限，然後存在buffer page，當你短時間在執行一次`ls -l`時就不用進入硬碟(因為很慢)
3. 橘色 - cache page (存檔案內容)，例如第一次下 `cat index.js`，就會把內容先讀取到 cache pages，如果你cat之後發現程式碼太長，決定只要下 `head -n 10 index.js`，就會從cache pages直接讀取

所以說記憶體使用量並非越低越好，畢竟賢在那邊也沒啥用，不如讓系統閒置的部分拿去做buffer或cache

> 所以不要相信什麼記憶體清理大師，隨便把buffer跟cache清掉只會加重系統負擔，記憶體管理就交給系統來，十之八九都可以管理得不錯

## Swap

Swap的機制和cache、buffer正好相反，萬一你實在開了太多程式，而每個程式都跟chrome一樣狂吃猛吃，導致memory快要不夠了

那系統就會把記憶體裡面一些東西swap到硬碟上，等真正需要時再拿回來

代價則是程式速度會慢上許多

# Load Average

`Task : 488 1994 thr; 3 running`

488 process

1994 threads

3個thread正在執行中(這個數字最大就是你的邏輯核心數)

Load Average (LA) 可以用來判斷目前系統有多繁忙

5.90, 4.19, 3.49 三個數字代表的是系統在最近1分鐘，5分鐘，15分鐘，平均有多少個thread需要CPU

a.k.a

最近一分鐘有5.9個thread需要CPU，但無奈我只有4個核心，所以CPU忙到翻過來

LA < 1 : 一般來說電腦完全沒在用時
1 < LA < 2 : 上網、聽音樂、做簡報

所以如果覺得自己的程式跑的很慢，不想先看看LA，確認瓶頸是不是CPU

如果LA很低，會慢的很誇張，那可能是程式沒有善用多核心，或是瓶頸卡在硬碟跟網路IO

如果LA已經很高了但還是太慢，那只能改善演算法，換更快的CPU，或是改用GPU了

# PID/USER

1. 知道PID之後可以幹嘛
   1. kill PID - 殺
   2. kill -STOP PID - 暫停
   3. kill -CONT PID - 繼續執行

# PRI & NI

Priority and Nice - 都是和優先權相關的指標，**數字越小優先權越高，也就是分配到越多CPU時間**

PRI - 系統幫你決定的，無法自行修改
NI - nice值通常預設都是0，可以透過`renice -n 19 -p <pid>`調整到最低優先權

雖然nice值可以隨自己高興調高調低，但系統不見得都會聽你的

有的系統設定比較友善會參考你設定的nice值，但也有一些只看PRI，完全不鳥你，所以不要期待提高優先權可以為笑能帶來多大變化，好好把程式寫好比較重要

# VIRT / RES / SHR

Virtual Memory

Resdident

Shared memory

可以想成process可以存取到的memory總和，譬如說`head -n index.js`內部運作方式是先把index.js打開，然後讀取前10行

**雖然只讀取前10行，但head process已經把檔案打開了，他其實有權限acess到整個檔案內容(只是他沒有這麼做)，所以Virtual memory會把整個檔案大小都算進去**

Resdient正好相反，**他指的是你物理上到底佔用多少記憶體**

以上例來說，Resdient就只算那10行

也就是說 RES一定會小於VIRT，而且通常是遠小於，因此看到VIRT很肥也不用太擔心

Shared memory

而 Shared memory 的話顧名思義就是可以跟別人分享的 memory，像程式執行時很常會用的 glibc，或是在讀取 read-only 檔案時，這些東西都只需要讀進記憶體一次就可以了，所以就會被算進 SHR 裡面
雖說能跟其他 process 共用記憶體是好事，但這種事也強求不來，所以一般我都只看 RES，很少在管 SHR 是多少

# State

process state

R : Running (正在跑) / running queue (正在等待被CPU執行)

如果你的程式處於R狀態但還是很慢，那可能是演算法太慢了，或是CPU一直讓你排隊，可以透過CPU%來確認是哪個問題

S : Sleep(正在睡覺，有事做才醒來)

通常定時執行的，例如ping, VSCode 很常睡覺
1. 畢竟ping一秒只送一個封包，現今CPU一秒可以跑10億個Cycle
2. VSCode 你總不可能一秒打10億個字吧

D : 也是睡覺，只不過等待的一定是IO，例如讀寫檔案或是資料庫

如果你的process長時間處於D狀態，代表IO所佔的時間比較多，三不五時就被CPU踢出去睡覺，因此要改善效能也要從IO著手，比如用Redis做快取或是SSD

# CPU% / MEM%

在此段時間內平均使用了幾顆CPU

htop 預設 3秒更新一次

1. 1.5秒前你用了一顆，後1.5秒都沒用，那平均就是50%
2. 3秒都用好用滿4顆，那就是400%

因為CPU%是很短期的數據，所以當你覺得電腦怪怪當當的，就直接看CPU%看是誰在作怪

然後看要用signal暫停還是殺掉他

MEM%也類似

要注意它是以RES來計算，所以如果電腦配有4GB，某個process的RES是1GB，那他就是用掉實體記憶體的25%

# TIME+

他代表的不是程式從啟動到現在總共經歷的時間

而是這個程式佔用了多少CPU TIME

譬如說上圖我在編譯 Rust 時，雖然我才剛跑十秒而已，但 CPU Time 已經有 28 秒，代表說這個 process 在十秒內平均使用了 2.8 顆 CPU，也就是平均的 CPU% 是 280% 左右

相反的如果像 ping 8.8.8.8 這種幾乎不需要 CPU 運算的 process（就只是把封包送出去而已），那即便跑了十多分鐘，佔用的 CPU Time 也不過 12 秒而已，平均起來的 CPU% 大概是 2% 左右

**所以如果想知道長期而言哪個程式最佔用CPU的話，優先看TIME+**

**想看正在爆衝的程式的話，則看CPU%**

