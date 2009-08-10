" wnodom.vim
"
" Vim colorscheme file
"

hi clear

set background=dark

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "wnodom"

hi Comment              gui=NONE    guifg=Grey                                term=bold           cterm=bold      ctermfg=cyan
hi Constant             gui=NONE    guifg=Cyan                                term=underline      cterm=bold      ctermfg=magenta
hi Cursor               gui=NONE    guifg=bg        guibg=#AAFFAA
hi CursorLine           gui=NONE                    guibg=Grey10
hi CursorColumn         gui=NONE                    guibg=Grey10
hi Directory            gui=NONE    guifg=Blue                                term=bold           cterm=bold      ctermfg=brown
hi Error                gui=NONE    guifg=Black     guibg=Red                 term=reverse                        ctermfg=darkcyan    ctermbg=black
hi ErrorMsg             gui=NONE    guifg=White     guibg=Red                 term=standout       cterm=bold      ctermfg=grey        ctermbg=blue
hi FoldColumn           gui=NONE    guifg=Grey      guibg=Grey15
hi Folded               gui=NONE    guifg=Cyan      guibg=#454545
hi Identifier           gui=NONE    guifg=Orange                              term=underline                      ctermfg=brown
hi LineNr               gui=NONE    guifg=DarkGrey  guibg=Black               term=underline      cterm=bold      ctermfg=darkcyan
hi MatchParen           gui=NONE                    guibg=DarkMagenta
hi Menu                 gui=NONE    guifg=black     guibg=Cyan
hi ModeMsg              gui=NONE    guifg=White     guibg=Blue                term=bold           cterm=bold
hi MoreMsg              gui=NONE    guifg=SeaGreen                            term=bold           cterm=bold      ctermfg=darkgreen
hi NonText              gui=NONE    guifg=Grey50    guibg=Grey20              term=bold           cterm=bold      ctermfg=darkred
hi Normal               gui=NONE    guifg=White     guibg=Black
hi PreProc              gui=NONE    guifg=#ff80ff                             term=underline                      ctermfg=darkblue
hi Question             gui=NONE    guifg=Green                               term=standout       cterm=bold      ctermfg=darkgreen
hi Scrollbar            gui=NONE    guifg=DarkCyan  guibg=Cyan
hi Search               gui=NONE    guifg=White     guibg=Red                 term=reverse                        ctermfg=white       ctermbg=red
hi SignColumn           gui=NONE                    guibg=Grey20
hi Special              gui=NONE    guifg=Orange                              term=bold           cterm=bold      ctermfg=red
hi SpecialKey           gui=NONE    guifg=Blue                                term=bold           cterm=bold      ctermfg=darkred
hi Statement            gui=NONE    guifg=#ffff60                             term=bold           cterm=bold      ctermfg=yellow
hi StatusLine           gui=NONE    guifg=#ffff60   guibg=Grey15              term=bold,reverse   cterm=bold      ctermfg=lightblue   ctermbg=white
hi StatusLineNC         gui=NONE    guifg=Grey50    guibg=Grey15              term=reverse                        ctermfg=white       ctermbg=lightblue
hi Title                gui=NONE    guifg=Magenta                             term=bold           cterm=bold      ctermfg=darkmagenta
hi Todo                 gui=NONE    guifg=Black     guibg=Yellow              term=standout       ctermfg=Black   ctermbg=darkcyan
hi Type                 gui=NONE    guifg=#60ff60                             term=underline      cterm=bold      ctermfg=lightgreen
hi VertSplit            gui=NONE    guifg=White     guibg=DarkGrey
hi Visual               gui=NONE    guifg=white     guibg=DarkCyan            term=reverse        cterm=reverse
hi WarningMsg           gui=NONE    guifg=Red                                 term=standout       cterm=bold      ctermfg=darkblue


" These are Perl-specific, but I don't (yet) know where else to put them.
"
hi perlPOD              gui=NONE    guifg=LightBlue                           term=bold           cterm=bold      ctermfg=cyan
hi perlString           gui=NONE    guifg=Cyan                                term=underline      cterm=bold      ctermfg=magenta
hi perlStringUnexpanded gui=NONE    guifg=#AAFFAA                             term=underline      cterm=bold      ctermfg=magenta
hi perlHereDoc          gui=NONE    guifg=White     guibg=#404040             term=underline      cterm=bold      ctermfg=magenta
hi perlDATA             gui=NONE    guifg=White     guibg=#002040             term=bold           cterm=bold      ctermfg=cyan
hi perlSpecial          gui=NONE    guifg=Lightred                            term=bold           cterm=bold      ctermfg=red


" ShowMarks highlight groups.
"
" ShowMarksHLl - lowercase marks
" ShowMarksHLu - uppercase marks
" ShowMarksHLo - all other marks
" ShowMarksHLm - multiple marks on same line
"
" Highlighting for lines without marks is controlled by the
" SignColumn highlight group. That's why the guibg color for
" each of the ShowMarksHL* is set the same as the SignColumn.
"
hi ShowMarksHLl         gui=NONE    guifg=White     guibg=Grey20
hi ShowMarksHLm         gui=NONE    guifg=Red       guibg=Grey20
hi ShowMarksHLo         gui=NONE    guifg=Green     guibg=Grey20
hi ShowMarksHLu         gui=NONE    guifg=White     guibg=Grey20

hi link IncSearch       Visual

hi link String          Constant
hi link Character       Constant
hi link Number          Constant
hi link Boolean         Constant

hi link Float           Number

hi link Function        Identifier

hi link Conditional     Statement
hi link Repeat          Statement
hi link Label           Statement
hi link Operator        Statement
hi link Keyword         Statement
hi link Exception       Statement

hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc

hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type

hi link Tag             Special
hi link SpecialChar     Special
hi link Delimiter       Special
hi link SpecialComment  Special
hi link Debug           Special

" end wnodom.vim

