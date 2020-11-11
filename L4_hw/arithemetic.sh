# run sh arithemetic.sh
# or run sh -x arithemetic.sh
read -p "please input a number: " x
read -p "please input another number: " y

sum=$[$x+$y]
echo the sum of the two numbers is $sum
echo "the sum of the two numbers is $sum" # also work