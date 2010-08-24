" (after/ftplugin) javascript.vim

" If this JavaScript file is a JSON file, then set the formatter
" appropriately.
"
" XXX: It would be nice to have a general-purpose JavaScript formatter to
" handle both code and JSON.
"
if expand("<afile>:e") == "json"
    setlocal equalprg=~/bin/format-json.pl
endif

