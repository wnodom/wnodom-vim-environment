" filetype.vim
"
" Additional filetypes not handled by $VIMRUNTIME/filetype.vim.
"

if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect

    " To ignore a filetype, add a line like this:
    "autocmd! BufNewFile,BufRead *.fs                   setfiletype ignored

    " ActionScript
    autocmd! BufNewFile,BufRead *.as                    setfiletype actionscript

    " Apache-style configuration files
    autocmd! BufNewFile,BufRead *.cfg                   setfiletype apachestyle

    " AppleScript
    autocmd! BufNewFile,BufRead *.applescript,*.scpt    setfiletype applescript

    " JSON (JavaScript Object Notation)
    autocmd! BufNewFile,BufRead *.json                  setfiletype javascript

    " Markdown / MultiMarkdown
    autocmd! BufNewFile,BufRead *.mkd,*.md              setfiletype mkd

    " MXML (Flex UI markup)
    autocmd! BufNewFile,BufRead *.mxml                  setfiletype mxml

    " PDF (Portable Document Format)
    autocmd! BufNewFile,BufRead *.pdf                   setfiletype pdf

    " SVG (Scalable Vector Graphics)
    autocmd! BufNewFile,BufRead *.svg                   setfiletype xml

    " Text (plain text)
    autocmd! BufNewFile,BufRead *.txt                   setfiletype text

    " XHTML
    autocmd! BufNewFile,BufRead *.xhtml                 setfiletype xml

augroup END

" end filetype.vim
