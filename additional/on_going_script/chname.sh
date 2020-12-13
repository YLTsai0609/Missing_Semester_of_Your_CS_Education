#!/bin/bash

# input : current_file_name e.g. keyword_4
# output : None
# PENDING : bash會根據空白切割，檔案，所以操作起來算是很麻煩，當前知識量不足 =()
# 用.py寫超級長的 =( 

# 將Desktop中有螢幕截圖 xxxxxx的png檔按照時間先後排序，最以前的在最前面，最近的在最後面，
# 依序命名為keyword_5.png, keyword_6.png, keyword_7.png,....... 一直到結束為止
# 這樣之後就不用一直手動改，直接run這個script，然後 mv ~/Desktop/*.png dir結束

# 需要針對此字串做分割，然後計算後面的數字一直加加加
echo $

# ls 然後排序
# t sort by modified time
# r reverse


for file in $(ls -rt ~/Desktop/螢幕快照*.png)
do 
    echo "calling $file"
done

# might a good options
# from https://stackoverflow.com/questions/7314044/use-bash-to-read-line-by-line-and-keep-space?fbclid=IwAR01rQleniGX3xZaJV43J8kyHodgRtQ8DcJNBACYwza51MmxZUO7BDC-c4k

# ls -rt ~/Desktop/螢幕快照*.png > tmp

# cat tmp | while read data
# do
#     echo "$data"
# done

