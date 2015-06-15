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

    " JSON (JavaScript Object Notation) and JSHint configuration files
    "
    autocmd! BufNewFile,BufRead *.json,.jshintrc        setfiletype javascript

    " LESS
    autocmd! BufNewFile,BufRead *.less                  setfiletype less

    " Markdown / MultiMarkdown
    "
    " XXX: Would be nice to auto-detect Markdown for *.txt files.
    "
    autocmd! BufNewFile,BufRead *.mkd,*.md              setfiletype markdown

    " MXML (Flex UI markup)
    autocmd! BufNewFile,BufRead *.mxml                  setfiletype mxml

    " PDF (Portable Document Format)
    autocmd! BufNewFile,BufRead *.pdf                   setfiletype pdf

    " SVG (Scalable Vector Graphics)
    autocmd! BufNewFile,BufRead *.svg                   setfiletype xml

    " Template Toolkit 2
    autocmd! BufNewFile,BufRead *.tt2                   setfiletype tt2

    " Text (plain text)
    autocmd! BufNewFile,BufRead *.txt                   setfiletype text

    " XHTML
    autocmd! BufNewFile,BufRead *.xhtml                 setfiletype xml

augroup END

" end filetype.vim
