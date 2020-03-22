* check crontab working or not
  * on mac `ps efaux | grep cron`
  * on ubunutu `ps efaux | grep cron` or `service cron status`
    * take a look for cron log `grep CRON /var/log/syslog`
    * Error message : `(CRON) info (No MTA installed, discarding output)` - server沒有Mail Transfer Agent
    * 解決 : 安裝mail server : `sudo apt-get install postfix`
    * **其實crontab跑不起來的原因超級多**，cron事實上開了一個超小的環境，所以env variable會長不一樣，而且愈紹用sh而非bash，甚至有的crontab要求最後一行要是新的空白行才能正確執行，可以參考這裡[Why crontab scripts are not working?](https://askubuntu.com/questions/23009/why-crontab-scripts-are-not-working)

* open a terminal when using vi
  * on mac, you have iterm2, `cmd + D` or `cmd + shift + D`
  * on ubuntu : 
