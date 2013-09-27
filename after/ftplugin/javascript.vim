" (after/ftplugin) javascript.vim

" Use 2-space indentation for JavaScript files.
"
setlocal tabstop=2      " Set the visible width of tabs.
setlocal softtabstop=2  " Edit as if tabs are 2 characters wide.
setlocal shiftwidth=2   " Number of spaces to use for indent and unindent.

" Wrap text at 78 columns, and show the colorcolumn at 79 characters.
"
setlocal textwidth=78
setlocal colorcolumn=+1

" If this JavaScript file is a JSON file, then set the formatter
" appropriately.
"
" XXX: It would be nice to have a general-purpose JavaScript formatter to
" handle both code and JSON.
"
if expand("<afile>:e") == "json"
    setlocal equalprg=~/bin/format-json.pl
endif

