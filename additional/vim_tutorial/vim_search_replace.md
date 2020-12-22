# vi/vim find and replace

You may wanna fix your program because it is borken. you don't wanna know all about the code. 
You wanna get the job done and go home!

## search

 `/your_keyword`

1. `/HOST` -> 尋找檔案中的HOST(從前面找)
2. `?HOST` -> 尋找檔案中的HOST(從後面找)

`n` -> next
`N` -> previous

## replace

same sytanx as `sed`

 `%s/search_from/replace_to/gc`

1. g -> global
2. c -> check (interative mode) highly recommand!
3. `%` -> all of the file or single line

 `:50,100s/search_from/replace_to/gc`

`:50,100s` means line nunber 50 - 100

# Reference

[vi / vim 搜尋並取代字串](https://www.opencli.com/linux/vi-vim-search-and-replace-string)
