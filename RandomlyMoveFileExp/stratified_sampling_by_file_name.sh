# 使用bash command
# Example

# ~/桌面/InitialMR_Datat/to_be_labelled_150/folder_1$
#  ls holo_* | shuf -n 2 | xargs -i -p mv {} ../folder_2

# {} only work on Unix-like platform
# 要用shuf或是head都可，因為前一段Sampling時已經shuf過了

# 想要測試請先
# mkdir folder_1 folder_2
# cd folder_1
# touch holo_1 holo_2 holo_3 holo_4 phone_1 phone_2

# DIR wjadmin@WJ2080Ti-002:~/桌面/InitialMR_Dataset/to_be_labelled_0$
# MAKE SURE fold_alen, flod_yulong, fold_poshih are all empty 
# RUN sh stratified_sampling_by_file_name.sh label_template/ fold_alen/ fold_yulong/ fold_poshih/

all_data=$1
folder_alen=$2
folder_yulong=$3
folder_poshih=$4
# all_data=label_template # for debug purpose
cd $PWD
for d in $(ls $all_data)
do
    # ls $PWD/$all_data/$dir
    for target in $(ls $all_data/$d)
    do
        holo_row=$(ls $all_data/$d/$target/*holo* | wc -l)
        phone_row=$(ls $all_data/$d/$target/*phone* | wc -l)
        nrows_holo_fold=$(($holo_row/3))
        nrows_phone_fold=$(($phone_row/3))
        echo $d/$target holo $holo_row each hold $nrows_holo_fold
        echo $d/$target  phone $phone_row each hold $nrows_phone_fold
        echo $d/$target rach fold total is  $(($nrows_holo_fold+$nrows_phone_fold))

        # phone
        ls $all_data/$d/$target/**phone** | head -n $nrows_phone_fold \
        | xargs -i  mv {} $folder_alen/$d/$target

        ls $all_data/$d/$target/**phone** | head -n $nrows_phone_fold \
        | xargs -i  mv {} $folder_poshih/$d/$target

        ls $all_data/$d/$target/**phone** | head -n $nrows_phone_fold \
        | xargs -i  mv {} $folder_yulong/$d/$target

        ls $all_data/$d/$target/**phone** | head -n $nrows_phone_fold \
        | xargs -i  mv {} $folder_poshih/$d/$target

        # holo
        ls $all_data/$d/$target/**holo** | head -n $nrows_holo_fold \
        | xargs -i  mv {} $folder_alen/$d/$target

        ls $all_data/$d/$target/**holo** | head -n $nrows_holo_fold \
        | xargs -i  mv {} $folder_poshih/$d/$target

        ls $all_data/$d/$target/**holo** | head -n $nrows_holo_fold \
        | xargs -i  mv {} $folder_yulong/$d/$target

        ls $all_data/$d/$target/**holo** | head -n $nrows_holo_fold \
        | xargs -i  mv {} $folder_yulong/$d/$target

    done
done