# handy linux commands/tips

> 紀錄工作中常用到的一些bash指令，以及使用場景
> 查看當前bash版本 `help`

# NetWork

|命令|使用場景|備註|
|---|-------|---|
| `ifconfig` |查自己的這台的ip||
| `ipython`  `import socket`  `socket.gethostbyname('deviceName')` |從A主機經由同網域的連線查詢B主機的ip|ipython要pytho3.5以上才支援|
| `ping` ip adress|從A主機經由同網域的連線查詢B主機目前的連接狀況及速度(time out, or speed xx/ms)|ping = 戳，測自己網速可以搭配內部迴圈網路 127.0.0.1|
| `nmap` IP/DNS|查詢子網域內所有ip以及DNS，有ip, 如果該機台有ssh, 就能夠進入 掃描範例 : `nmap 192.169.0.*` 掃描此之下所有子網域, `nmap www.hinet.net` 透過DNS。掃描需要一段時間| `nmap` 需要安裝，mac透過 `brew` , ubuntu透過 `apt` ，DNS全名為Domain Name System|
| `scp userName@ip adress:filePath MyfilePath` |已知主機filePath，從主機抓檔案/資料夾到本地端||
| `scp MyfilePath userName@ip adress:filePath` |把本地端的檔案copy到主機端的目錄|
| `ssh userName@ip adress` |經由ssh連線到主機端，但主機端需要是一個ssh server，或是有給予ssh金鑰|mac需要打開"允許遠端登入" "系統偏好設定" --> "共享" --> "遠端登入"|
| `curl ifconfig.me` |查詢目前該機台的外部IP，多個機台可能是一樣的外部IP|

* [鳥哥一下 : [第11章、遠端連線伺服器 SSH/XDMCP/VNC/RDP]](http://linux.vbird.org/linux_server/0310telnetssh.php#scp)
* [scp 簡明使用守則](http://note.drx.tw/2008/03/ubuntuscp-part1.html)

## 指令

### `curl`

Support protocols : `DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET, TFTP`

|命令|意思|
|---|----|
|`curl http://example.com -o filename`|download the contents of an URL to a file|
|`curl -d 'name-bob' http://example.com/form` |send form-encoded data(POST request of type `application/x-www-form-urlencoded`)|
|`curl -H 'X-My-Header: 123 -X PUT http://example.com'`|Send a request with an extra header, using a custom HTTP method|
|`curl -d '{"name":"bob"}' -H 'Content-Type: application/json http://example.com/users/1234'`|Send data is JSON format, specifying the appropriate content-type header|
|`curl -u myusername:mypassword http://example.com`|Pass a user name and password for server authentication|
|`curl --request POST --url http://example.com/ -H 'Content-Type : application/json' -H 'x-authoriztion : xxxx' --data '[...]'`|Send data by post method with headers|

### `http`

|命令|意思|
|---|----|
|`http -d example.org`| download a url to a file|
|`http -f example.org name='bob' profile_picture@'bob.png'`| Send form-encoded data|
|`http example.org name='bob`|send json object|
|`http HEAD example.org`|Specify an HTTP method|
|`http example.org X-MyHeader:123`|Include an extra header|
|`http -a username:password example.org`|Pass user name and password|
|`cat data.txt | http PUT example.org`||
|`http get url query:='{"match":{"author_id":"drm88"}}'`| get request from a url by query string.|

## 觀念

### 關於固定IP與浮動IP

真實IP, 實體IP, 虛IP, 假的IP, 其實沒有分沒有那麼多種，在IPv4裡面，只有兩種IP類別，其他你聽到的基本上是IP的取得方式
<br>

  + Public IP : 公共IP，經由INTERNIC所統一規劃的IP，有這種IP才能上Internet
  + Private IP : 私有IP或是保留IP，不能直接連上Internet的IP，主要用於區域網路內的主機連線規劃

IPv4規劃時就擔心IP會不足，而且為了應付某些企業內部的網路設定，於是有了私有IP的產生，私有IP也分別在A, B, C三個Class中個保留一段作為私有IP網段

  + Class A : 10.0.0.0 - 10.255.255.255
  + Class B : 172.16.0.0 - 172.31.255.255
  + Class C : 192.168.0.0 - 192.168.255.255

### 還有一個特殊網段 loopback IP

  + 127.0.0.1 : 內部迴圈網路 當你要測試你的TCP/IP封包與狀態是否正常時，就可以使用
* 所謂ip取得方式 

### 所以主機的IP是如何設定的?

  + 直接手動設定(static) 所謂的固定ip : 你可以直接向你的網管詢問可用的ip相關參數，然後直接編輯設定檔(或使用某些軟體功能來設定你的網路)。常見於校園網路環境、或是自架封閉區網、或是像ISP申請固定ip的連線環境

  

  + 撥接取得 : 向你的ISP註冊，取得帳號密碼後，直接撥接到ISP，你的ISP或透過他自己的設定，讓你的作業系統取得正確的網路參數。此時你**不用手動編輯與設定相關的網路參數**。目前台灣的ADSL，光纖到大樓、光纖到府，大部分都是使用撥接方式。為了因應客戶需求，某些ISP也提供很多不同的IP分配機制。包含hinet, seednet等都有提供ADSL撥接後取得固定ip的方式，詳情可以向自己的ISP洽詢XD。

  + 自動取得網路參數(DHCP - Dynamic Host Configguration Protocol) 所謂浮動ip : 在區域網路內會有一部主機負責管理所有電腦的網路參數，**你的網路啟動時，就會主動向伺服器要求IP參數**，若取得網路相關參數後，你的儲機就能夠自行設定好所有伺服器給你的網路參數。最常使用於企業內部、IP分享器後端、校園網路與宿舍環境、纜線寬頻等連線方式。

* [鳥哥一下 - 第二章、網路基礎概念 2.3.3 IP的種類與取得方式](http://linux.vbird.org/linux_server/0110network_basic.php#tcpip_network_type)

* [terminal 設定固定ip](https://blog.toright.com/posts/6293/ubuntu-18-04-%E9%80%8F%E9%81%8E-netplan-%E8%A8%AD%E5%AE%9A%E7%B6%B2%E8%B7%AF%E5%8D%A1-ip.html)

<br>

### 總結 : 

  > 只有公共IP和私有IP，固定IP及浮動IP指的是取得方式，手一揮，假的

## ifconfig/ipconfig

* (InterFace config) 提供檢測以及網路介面卡進行互動的指令

|名詞|解釋|備註|
|----|---|---|
|eth0|偵測到的介面名稱(Ethernet0的縮寫)|如果系統中有更多乙太網路介面，則會一一列出|
|EthernetHWaddr : `00:0c:29:ba:....` |網路介面卡位置，稱為MAC(media access control address)|
|inet addr|當前分配給網卡的IP位置(可能是固定IP或是浮動IP)|
|Bcast|broadcast address，廣播位置，用來發送給所有位於子網路內機台訊息的ip位置||
|Mask|網路遮罩，決定哪一部分是屬於網路或是主機||
|lo|loopback adress, localhost|連接到本地系統，測試用|
|wlan0|**無線網路介面卡**裝置||
|LAN|Local Area Network 區域網路||

* ipconfig是windows上的ifconfig

## iwconfig

* (Interface wireless config) 無線網卡的相關config
* Ubuntu上面有，但mac尚有編譯問題，沒辦法安裝

* ifconfig的潛能
* 修改本機IP位置(暫時的，永久修改要google)，變更網路遮罩，變更廣播位置，竄改MAC位置
* DHCP (Dynamic Host Configguration Protocol)能夠透過這個協定和基地台溝通，修正發送下來的IP，但在mac中需要google一下是用什麼指令，然後brew安裝它

## 操控DNS

* DNS : IP <--> www.google.com(人類看得懂的網域名稱)
* Hacker能夠從其中竊取許多關於入侵目標的重要資訊
* `dig`能夠搜尋有關目標域名的DNS資訊
* 改變DNS Server
  + 相關檔案在Unix-like的系統之下被放在/etc/resolv.conf的domain以及nameserver
  + 透過修改donmain以及nameserver就能夠自訂跳板服務([VPN - Virtual Private Network](https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF))
* 自定義IP位置
* 相關檔案在Unix-like的系統之下被放在/etc/hosts
* 可以自訂一個IP，然後後面接一個DNS，該主機連線到該IP時就會被重定向到指定DNS，可以透過狹持TCP連線引導至惡意網站

## nmap

nmap <type of scan> <target IP> <optionally, target port>

* nmap 掃描自己區網內所有連網裝置IP, Port, 及開啟的服務
  + 先透過ifconfig, 如果屬於一個區網(LAN)，則取前三碼，例如192.168.0
  + nmap 192.168.0.* > scanlist.txt
* 可以搭配**封包監聽**，**封包攔截**，如果有人正在傳送密碼而且是明碼，就可以截取到密碼。
* 不局限於區網，只要有IP就可以實作任何的掃描
  + `echo Enter the starting IP adress`
  + `read FirstIP`
  + `nmap ${FirstIP}-${LastOctIP}...`

### More about SSH

pass

### 即時串流相關協定

* 動機 : 在樹莓派上利用TPU做Edge Computing，將結果及影片即時串流回主機Server，原本使用base64將 video image 壓縮成base64字串，在Client端再用based64 decode，但這個方法扔然會延遲。
* 概念 : 回想一下我們對影片的上傳下載，由於多媒體檔案通常都比較大，所需要的儲存容量也大，由於網路頻寬的限制，下載多媒體檔案都需要花費數分鐘甚至數小時，所以如果是這種下載方法來傳送多媒體檔案的延遲會非常大
* 串流(Streamming)的概念，只將開始部分存入記憶體，資料流隨時傳送隨時播放，只會在開始時有一些延遲，中間過程通常都會非常順暢，下列為網路串流發展的一些歷史 : 

 
|協定|解釋|
|---|----|
|RTP(Real-time Transport Protocol) 即時傳輸協議|串流協定剛開始發展的協定之一|
|RTMP：即時傳輸訊息協議(Real Time Messaging Protocol)|被Flash用於物件, 影片, 音訊傳輸, 這個協定建立在TCP或是HTTP之上，由於被包裹在TCP裏頭，實作出來畫質還可以，但延遲時間有2秒左右，對於Realtime的要求來說還是較長。|
|RTSP：即時串流協議(Real Time Streaming Protocol)|除了控制聲音或是影像外，還可以允許同時多個串流需求控制，並且可以自己選擇要用TCP或是UPD來進行串流內容，在這個Protocol中可以傳送播放、錄製、暫停等等控制協定、蠻像遙控錄影機的。|

* 上述中的RTSP也是我們採用的協定，[其Wiki在這裡](https://zh.wikipedia.org/wiki/%E5%8D%B3%E6%99%82%E4%B8%B2%E6%B5%81%E5%8D%94%E5%AE%9A)
* 套件實作 GStreamer, based on C，可以使用樹莓派硬體進行H.264編碼，串流品質優

# subnetwork mask(子網路遮罩)

用於確認兩個IP是否屬於同個網域，計算方式如下

host_1 : `192.168.0.21`

host_2 : `192.168.0.31`

subnetwork mask(子網路遮罩) : `255.255.255.0`

公式 ip of host_1 in binary && subnetwork mask in binary == ip of host_2 in binary && subnetwork mask in binary 

Then : host_1 and host_2 in the same subnetwork

or just ping another ip address
