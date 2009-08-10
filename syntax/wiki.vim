" Vim syntax file
" Copied from:
" Language:     FlexWiki, http://www.flexwiki.com/
" Maintainer:   George V. Reilly  <george@reilly.org>
" Home:         http://www.georgevreilly.com/vim/flexwiki/
" Other Home:   http://www.vim.org/scripts/script.php?script_id=1529
" Author:       George V. Reilly
" Filenames:    *.wiki
" Last Change: Wed Apr 26 11:00 PM 2006 P
" Version:      0.3

" Quit if syntax file is already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" A WikiWord (unqualifiedWikiName)
" syntax match  stwikiWord          /\%(_\?\([A-Z]\{2,}[a-z0-9]\+[A-Za-z0-9]*\)\|\([A-Z][a-z0-9]\+[A-Za-z0-9]*[A-Z]\+[A-Za-z0-9]*\)\)/
" A [bracketed wiki word]
syntax match  stwikiWord          /\[[[:alnum:]\s]\+\]/

" text: "this is a link (optional tooltip)":http://www.microsoft.com
" TODO: check URL syntax against RFC
syntax match stwikiLink           `\("[^"(]\+\((\([^)]\+\))\)\?":\)\?\(https\?\|ftp\|gopher\|telnet\|file\|notes\|ms-help\):\(\(\(//\)\|\(\\\\\)\)\+[A-Za-z0-9:#@%/;$~_?+-=.&\-\\\\]*\)`

" text: *strong* 
syntax match stwikiBold           /\(^\|\W\)\zs\*\([^\* ].\{-}\)\*/

" text: _emphasis_
syntax match stwikiItalic         /\(^\|\W\)\zs_\([^ ].\{-}\)_/
" ''italic''
syntax match stwikiItalic         /''\([^'].\{-}\)''/

" `code`
syntax match stwikiCode     /`\([^`].\{-}\)`/

"   text: -deleted text- 
syntax match stwikiDelText        /\(^\|\s\+\)\zs-\([^ <a ]\|[^ <img ]\|[^ -].*\)-/

" Aggregate all the regular text highlighting into stwikiText
syntax cluster stwikiText contains=stwikiItalic,stwikiBold,stwikiCode,stwikiDelText,stwikiLink,stwikiWord

" single-line WikiPropertys
syntax match stwikiSingleLineProperty /^:\?[A-Z_][_a-zA-Z0-9]\+:/

" TODO: multi-line WikiPropertys

" Header levels, 1-6
syntax match stwikiH1             /^\^.*$/
syntax match stwikiH2             /^\^\^.*$/
syntax match stwikiH3             /^\^\^\^.*$/
syntax match stwikiH4             /^\^\^\^\^.*$/
syntax match stwikiH5             /^\^\^\^\^\^.*$/
syntax match stwikiH6             /^\^\^\^\^\^\^.*$/

" <hr>, horizontal rule
syntax match stwikiHR             /^----.*$/

" Tables. Each line starts and ends with '||'; each cell is separated by '||'
syntax match stwikiTable          /|/

" Bulleted list items start with one or tabs, followed by whitespace, then '*'
" Numeric  list items start with one or tabs, followed by whitespace, then '1.'
" Eight spaces at the beginning of the line is equivalent to the leading tab.
syntax match stwikiList           /^\(\*\|#\)\+.*$/   contains=@stwikiText

" Treat all other lines that start with spaces as PRE-formatted text.
syntax match stwikiPre            /^[ \t]\+[^ \t*1].*$/


" Link stWiki syntax items to colors
hi def link stwikiH1                    Title
hi def link stwikiH2                    stwikiH1
hi def link stwikiH3                    stwikiH2
hi def link stwikiH4                    stwikiH3
hi def link stwikiH5                    stwikiH4
hi def link stwikiH6                    stwikiH5
hi def link stwikiHR                    stwikiH6
    
hi def stwikiBold                       term=bold cterm=bold gui=bold
hi def stwikiItalic                     term=italic cterm=italic gui=italic

hi def link stwikiCode                  Statement
hi def link stwikiWord                  Underlined

hi def link stwikiEscape                Todo
hi def link stwikiPre                   PreProc
hi def link stwikiLink                  Underlined
hi def link stwikiList                  Type
hi def link stwikiTable                 Type
hi def link stwikiDelText               Comment

hi def link stwikiSingleLineProperty    Identifier

let b:current_syntax="stWiki"

" vim:tw=0:
