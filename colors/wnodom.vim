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


hi Comment              gui=NONE    guifg=Grey                                term=bold           cterm=bold      ctermfg=Cyan
hi Constant             gui=NONE    guifg=Cyan                                term=underline      cterm=bold      ctermfg=Magenta
hi Cursor               gui=NONE    guifg=bg        guibg=#AAFFAA
hi CursorLine           gui=NONE                    guibg=Grey30
hi CursorColumn         gui=NONE                    guibg=Grey30
hi ColorColumn          gui=NONE                    guibg=DarkRed
hi Directory            gui=NONE    guifg=Cyan                                term=bold           cterm=bold      ctermfg=Cyan
hi Error                gui=NONE    guifg=Black     guibg=Red                 term=reverse                        ctermfg=DarkCyan    ctermbg=Black
hi ErrorMsg             gui=NONE    guifg=White     guibg=Red                 term=standout       cterm=bold      ctermfg=Grey        ctermbg=Blue
hi FoldColumn           gui=NONE    guifg=Grey      guibg=Grey15
hi Folded               gui=NONE    guifg=White     guibg=DarkGreen
hi Identifier           gui=NONE    guifg=Orange                              term=underline                      ctermfg=Brown
hi LineNr               gui=NONE    guifg=DarkGrey  guibg=Black               term=underline      cterm=bold      ctermfg=DarkCyan
hi MatchParen           gui=NONE                    guibg=DarkMagenta
hi Menu                 gui=NONE    guifg=Black     guibg=Cyan
hi ModeMsg              gui=NONE    guifg=White     guibg=Blue                term=bold           cterm=bold
hi MoreMsg              gui=NONE    guifg=SeaGreen                            term=bold           cterm=bold      ctermfg=DarkGreen
hi NonText              gui=NONE    guifg=Grey50    guibg=Grey20              term=bold           cterm=bold      ctermfg=DarkRed
hi Normal               gui=NONE    guifg=White     guibg=Black
hi PreProc              gui=NONE    guifg=#ff80ff                             term=underline                      ctermfg=DarkBlue
hi Question             gui=NONE    guifg=Green                               term=standout       cterm=bold      ctermfg=DarkGreen
hi Scrollbar            gui=NONE    guifg=DarkCyan  guibg=Cyan
hi Search               gui=NONE    guifg=White     guibg=DarkGreen           term=reverse                        ctermfg=White       ctermbg=Red
hi SignColumn           gui=NONE                    guibg=Grey20
hi Special              gui=NONE    guifg=Orange                              term=bold           cterm=bold      ctermfg=Red
hi SpecialKey           gui=NONE    guifg=Black     guibg=Orange              term=bold           cterm=bold      ctermfg=DarkRed
hi Statement            gui=NONE    guifg=#ffff60                             term=bold           cterm=bold      ctermfg=Yellow
hi StatusLine           gui=NONE    guifg=Black     guibg=#ffff60             term=bold,reverse   cterm=bold      ctermfg=LightBlue   ctermbg=White
hi StatusLineNC         gui=NONE    guifg=Grey50    guibg=Grey15              term=reverse                        ctermfg=White       ctermbg=LightBlue
hi Title                gui=NONE    guifg=#ffff60                             term=bold           cterm=bold      ctermfg=DarkMagenta
hi Todo                 gui=NONE    guifg=Black     guibg=Yellow              term=standout                       ctermfg=Black       ctermbg=DarkCyan
hi Type                 gui=NONE    guifg=#60ff60                             term=underline      cterm=bold      ctermfg=LightGreen
hi VertSplit            gui=NONE    guifg=White     guibg=DarkGrey
"hi Visual              gui=NONE    guifg=White     guibg=DarkCyan            term=reverse        cterm=reverse
hi Visual               gui=NONE    guifg=White     guibg=#3c6182             term=reverse        cterm=reverse
hi WarningMsg           gui=NONE    guifg=Red                                 term=standout       cterm=bold      ctermfg=Darkblue


" Perl-specific colors
"
hi perlPOD              gui=NONE    guifg=LightBlue                           term=bold           cterm=bold      ctermfg=Cyan
hi perlString           gui=NONE    guifg=Cyan                                term=underline      cterm=bold      ctermfg=Magenta
hi perlStringUnexpanded gui=NONE    guifg=#AAFFAA                             term=underline      cterm=bold      ctermfg=Magenta
hi perlHereDoc          gui=NONE    guifg=White     guibg=#404040             term=underline      cterm=bold      ctermfg=Magenta
hi perlDATA             gui=NONE    guifg=White     guibg=#002040             term=bold           cterm=bold      ctermfg=Cyan
hi perlSpecial          gui=NONE    guifg=LightRed                            term=bold           cterm=bold      ctermfg=Red

" Taglist highlight groups
"
" hi TagListTagName  
" hi TagListTagScope 
" hi TagListTitle    
" hi TagListComment  
hi TagListFileName      gui=NONE    guifg=Cyan      guibg=Black


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

" NERDTree highlight groups (temporarily here for reference)
"
" hi treeFlag
" hi treeUp
" hi treeClosable
" hi treeOpenable
" hi treePart
" hi treePartFile
" hi treeHelpKey
" hi treeHelpTitle
" hi treeToggleOn
" hi treeToggleOff
" hi treeHelpCommand
" hi treeHelp
" hi treeBookmark
" hi treeRO
" hi treeDirSlash
" hi treeLink
" hi treeDir
" hi treeExecFile
" hi treeFile
" hi treeCWD
" hi treeBookmarksLeader
" hi treeBookmarksHeader
" hi treeBookmarksName
" hi NERDTreeCurrentNode



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
