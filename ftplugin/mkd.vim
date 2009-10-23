" (after/ftplugin) mkd.vim
"
" Markdown settings
"

setlocal autoindent

setlocal formatoptions&vim  " reset to Vim default (tcq)
setlocal formatoptions+=n   " recognize numbered lists
setlocal formatoptions+=2   " use 2nd line of indent when formatting (XXX: May not want this one)
setlocal formatoptions+=r   " insert comment leader after hitting <Enter> in Insert mode
setlocal formatoptions+=o   " insert comment leader after hitting 'o' or 'O' in Normal mode

setlocal comments=n:>       " allow nested comments starting with >

setlocal wrap               " wrap display of long lines at screen width
