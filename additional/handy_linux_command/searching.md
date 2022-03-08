# 關於找檔案、考古 --> 搜尋

1. [找檔案 - find, locate, which, whereis](https://github.com/YLTsai0609/Missing_Semester_of_Your_CS_Education/blob/master/additional/handy_linux_command/misc.md)
2. [快速了解 command 如何使用 - tldr](https://github.com/tldr-pages/tldr-python-client)
   1. 可以不需要 super user, `pip install tldr`
3. [對檔案全文搜索 - 直接在terminal - ag](https://shengyu7697.github.io/linux-ag/)
   1. 需要 super user

# 心法

1. 參考架構 --> 從 api routing 尋找關鍵字，透過任何的搜尋(ag, VSCode, repo search) - 對檔案全文檢索
2. 從關鍵字取得更多線索 --> 包含寫法、變數命名等
3. 從軟體架構 pattern 取得更多線索 
   1. Data engineering - etl, speed layer, batch layer
   2. 環境建立 - Makefile, Boostrap file, envs
4. 從測試範例取得更多線索
   1. minimum example usage of object
5. 從商業邏輯取得更多線索
   1. search - articles, autosuggestions, pois, images, ...