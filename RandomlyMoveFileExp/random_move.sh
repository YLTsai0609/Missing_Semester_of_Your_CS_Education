cd $PWD

for file in $(ls $1 | shuf -n $3)
do 
    mv "$1/$file" $2
    echo "moving "$1/$file" from $1 to $2"
done