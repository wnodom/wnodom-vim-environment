" filetype.vim
"
" Additional filetypes not handled by $VIMRUNTIME/filetype.vim.
"

if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect

    " To ignore a filetype, add a line like this:
    "autocmd! BufNewFile,BufRead *.fs            setfiletype ignored

    " ActionScript (Flash and Flex)
    autocmd! BufNewFile,BufRead *.as            setfiletype actionscript

    " Apache-style configuration files
    autocmd! BufRead,BufNewFile *.cfg           setfiletype apachestyle

    " AppleScript
    autocmd! BufNewFile,BufRead *.applescript,*.scpt
        \                                       setfiletype applescript

    " JSON (JavaScript Object Notation)
    autocmd! BufNewFile,BufRead *.json          setfiletype javascript

    " Markdown (http://daringfireball.net/projects/markdown/)
    autocmd! BufRead,BufNewFile *.mkd           setfiletype mkd

    " MXML (Flex UI markup)
    autocmd! BufNewFile,BufRead *.mxml          setfiletype mxml

    " PDF (Portable Document Format)
    autocmd! BufNewFile,BufRead *.pdf           setfiletype pdf

    " Scalable Vector Graphics
    autocmd! BufNewFile,BufRead *.svg           setfiletype xml

    " Text (plain text)
    autocmd BufReadPost *.txt                   setfiletype text

    " XHTML
    autocmd! BufNewFile,BufRead *.xhtml         setfiletype xml

augroup END

" end filetype.vim
