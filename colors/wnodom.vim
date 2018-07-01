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


hi Comment              gui=NONE       guifg=Grey
hi Constant             gui=NONE       guifg=Cyan
hi Cursor               gui=NONE       guifg=bg        guibg=#AAFFAA
hi CursorLine           gui=NONE                       guibg=Grey30
hi CursorColumn         gui=NONE                       guibg=Grey30
hi ColorColumn          gui=NONE                       guibg=DarkRed
hi Directory            gui=NONE       guifg=Cyan
hi Error                gui=NONE       guifg=Black     guibg=Red
hi ErrorMsg             gui=NONE       guifg=White     guibg=Red
hi FoldColumn           gui=NONE       guifg=Grey      guibg=Grey15
hi Folded               gui=NONE       guifg=White     guibg=DarkGreen
hi Identifier           gui=NONE       guifg=Orange
hi LineNr               gui=NONE       guifg=Grey25    guibg=Black
hi MatchParen           gui=NONE                       guibg=DarkMagenta
hi Menu                 gui=NONE       guifg=Black     guibg=Cyan
hi ModeMsg              gui=NONE       guifg=White     guibg=Blue
hi MoreMsg              gui=NONE       guifg=SeaGreen
hi NonText              gui=NONE       guifg=Grey50    guibg=Grey20
hi Normal               gui=NONE       guifg=White     guibg=Black
hi Pmenu                gui=NONE       guifg=White     guibg=DarkMagenta
hi PreProc              gui=NONE       guifg=#ff80ff
hi Question             gui=NONE       guifg=Green
hi Scrollbar            gui=NONE       guifg=DarkCyan  guibg=Cyan
hi Search               gui=NONE       guifg=White     guibg=Red
hi SignColumn           gui=NONE       guifg=White     guibg=Black
hi Special              gui=NONE       guifg=Orange
hi SpecialKey           gui=NONE       guifg=Black     guibg=Orange
hi SpellBad             gui=NONE                       guibg=DarkRed
hi Statement            gui=NONE       guifg=#ffff60
hi StatusLine           gui=NONE       guifg=Black     guibg=#ffff60
hi StatusLineNC         gui=NONE       guifg=Grey50    guibg=Grey15
hi Title                gui=NONE       guifg=#ffff60
hi Todo                 gui=NONE       guifg=Black     guibg=Yellow
hi Type                 gui=NONE       guifg=#60ff60
hi VertSplit            gui=NONE       guifg=Grey50    guibg=Grey15
hi Underlined           gui=underline  guifg=LightBlue
hi Visual               gui=NONE       guifg=White     guibg=#3c6182
hi WarningMsg           gui=NONE       guifg=Red


" Perl-specific colors
"
hi perlPOD              gui=NONE       guifg=LightBlue
hi perlString           gui=NONE       guifg=Cyan
hi perlStringUnexpanded gui=NONE       guifg=#AAFFAA
hi perlHereDoc          gui=NONE       guifg=White     guibg=#404040
hi perlDATA             gui=NONE       guifg=White     guibg=#002040
hi perlSpecial          gui=NONE       guifg=LightRed


" Taglist highlight groups
"
" hi TagListTagName
" hi TagListTagScope
" hi TagListTitle
" hi TagListComment
"
hi TagListFileName      gui=NONE       guifg=Cyan      guibg=Black


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
hi ShowMarksHLl         gui=NONE       guifg=White     guibg=Grey20
hi ShowMarksHLm         gui=NONE       guifg=Red       guibg=Grey20
hi ShowMarksHLo         gui=NONE       guifg=Green     guibg=Grey20
hi ShowMarksHLu         gui=NONE       guifg=White     guibg=Grey20


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

" NERDTree file highlighting based on extension, adapted from
" <https://github.com/ryanoasis/vim-devicons/wiki/FAQ-&-Troubleshooting>
"
function! NERDTreeHighlightFile(extension, guifg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension . ' guifg=' . a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension . ' #^\s\+.*' . a:extension . '$#'
endfunction

call NERDTreeHighlightFile('ts',            '#60ff60')
call NERDTreeHighlightFile('js',            'pink')
call NERDTreeHighlightFile('json',          'wheat')
call NERDTreeHighlightFile('html',          '#ffff60')
call NERDTreeHighlightFile('css',           '#ffaf4d')
call NERDTreeHighlightFile('scss',          '#ffaf4d')
call NERDTreeHighlightFile('DS_Store',      'grey')
call NERDTreeHighlightFile('gitignore',     'grey')
call NERDTreeHighlightFile('editorconfig',  'grey')


" Syntastic highlight groups
"
" SyntasticErrorSign          - For syntax errors, links to "error" by default
" SyntasticWarningSign        - For syntax warnings, links to "todo" by default
" SyntasticStyleErrorSign     - For style errors, links to "SyntasticErrorSign" by default
" SyntasticStyleWarningSign   - For style warnings, links to "SyntasticWarningSign" by default
"
" SyntasticError              - Links to "SpellBad" by default (see |hl-SpellBad|)
" SyntasticWarning            - Links to "SpellCap" by default (see |hl-SpellCap|)
" SyntasticStyleError         - Links to "SyntasticError" by default
" SyntasticStyleWarning       - Links to "SyntasticWarning" by default
"
hi SyntasticErrorSign   gui=NONE guifg=Red
hi SyntasticWarningSign gui=NONE guifg=Yellow


" ALE highlight groups
"
" ALEError    - Links to "SpellBad" by default
" ALEWarning  - Links to "SpellCap" by default
"
hi ALEErrorSign     gui=NONE guifg=Red
hi ALEWarningSign   gui=NONE guifg=Yellow


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
