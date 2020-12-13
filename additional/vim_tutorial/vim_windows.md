# vi/vim windows

Sometimes you don't like tmux to set up all of the configs. 
You just want to use vim directly.

## same file, different pointer

| command                       | usage                                | note                                                                                                                  |
|-------------------------------|--------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
`ctrl + w + v` , `:split` |splits the same file vertically|for reference to check your file|
`ctrl + w + s` , `vsplit` |splits the same file horizontally|for reference to check your file|
`!ls` |run a bash command then show the result on your current screen|very useful if don't know what the files are in current directory|
`!any_bash_command` |run a bash command then show the result on your current screen|very useful if don't if you wanna quickly check something.|
|||
`vert term` |splits the windows vertically and give you a bash shell||

# Reference

[vim cheatsheet](https://vim.rtorr.com/lang/en_us)
[Vim分割視窗](https://2formosa.blogspot.com/2016/07/vim-split-window.html)
