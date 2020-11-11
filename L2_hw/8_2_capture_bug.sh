#! /bin/bash
# 此file會測試某個script，200次，並將output以及錯誤訊息寫到當前目錄中的curr.out
for i in `seq 1 200`;
do
	# 把參數的file跑起來，stdout以覆蓋模式存在curr.out，stderr已覆蓋模式存在curr.err
	bash $1 > curr.out 2> curr.err 
	# 如果跑失敗，capture
	
	if [[ $? -ne 0 ]]; then
		# 存在一個file，稱為8_3_result.md
		echo "$i failed" 
		echo "ITERATION $i" >> 8_3_result.md
		echo "STDOUT BLOW" >> 8_3_result.md
		cat curr.out >> 8_3_result.md
		echo "ERROR BLOW" >> 8_3_result.md
		cat curr.err >> 8_3_result.md
		echo "Bug Captured! at iteration $i"
	fi
# 	echo "$i successed"
done
rm curr.out
rm curr.err
