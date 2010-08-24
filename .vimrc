" .vimrc
"
" Settings for both console and GUI Vim sessions.
" (See .gvimrc for GUI-specific settings.)
"

" Use Vim settings instead of Vi settings. Set this early,
" as it changes many other options as a side effect.
"
set nocompatible

set shortmess+=I        " Don't show the Vim welcome screen.

set autoindent          " Copy indent from current line for new line.
set nosmartindent       " 'smartindent' breaks right-shifting of # lines.

set hidden              " Keep changed buffers without requiring saves.

set history=500         " Remember this many command lines.

set ruler               " Always show the cursor position.
set showcmd             " Display incomplete commands.
set incsearch           " Do incremental searching.
set hlsearch            " Highlight latest search pattern.
set number              " Display line numbers.
set numberwidth=4       " Minimum number of columns to show for line numbers.
set laststatus=2        " Always show a status line.
set vb t_vb=            " Use null visual bell (no beeps or flashes).

set scrolloff=3         " Context lines at top and bottom of display.
set sidescrolloff=5     " Context columns at left and right.
set sidescroll=1        " Number of chars to scroll when scrolling sideways.

set nowrap              " Don't wrap the display of long lines.
set linebreak           " Wrap at 'breakat' char vs display edge if 'wrap' on.
set display=lastline    " Display as much of a window's last line as possible.

set splitright          " Split new vertical windows right of current window.
set splitbelow          " Split new horizontal windows under current window.

set winminheight=0      " Allow windows to shrink to status line.
set winminwidth=0       " Allow windows to shrink to vertical separator.

set expandtab           " Insert spaces for <Tab> press; use spaces to indent.
set smarttab            " Tab respects 'shiftwidth', 'tabstop', 'softtabstop'.
set tabstop=4           " Set the visible width of tabs.
set softtabstop=4       " Edit as if tabs are 4 characters wide.
set shiftwidth=4        " Number of spaces to use for indent and unindent.
set shiftround          " Round indent to a multiple of 'shiftwidth'.

set ignorecase          " Ignore case for pattern matches (\C overrides).
set smartcase           " Override 'ignorecase' if pattern contains uppercase.
set nowrapscan          " Don't allow searches to wrap around EOF.

set nocursorline        " Don't highlight the current screen line...
set nocursorcolumn      " ...or column.

set virtualedit=block   " Allow virtual editing when in Visual block mode.

set foldcolumn=3        " Number of columns to show at left for folds.
set foldnestmax=3       " Only allow 3 levels of folding.
set foldlevelstart=99   " Start with all folds open.

set whichwrap+=<,>,[,]  " Allow left/right arrows to move across lines.

set nomodeline          " Ignore modelines.
set nojoinspaces        " Don't get fancy with the spaces when joining lines.
set textwidth=0         " Don't auto-wrap lines except for specific filetypes.

" Turn 'list' off by default, since it interferes with 'linebreak' and
" 'breakat' formatting (and it's ugly and noisy), but define characters to use
" when it's turned on.
"
set nolist
set listchars =tab:>-           " Start and body of tabs
set listchars+=trail:.          " Trailing spaces
set listchars+=extends:>        " Last column when line extends off right
set listchars+=precedes:<       " First column when line extends off left
set listchars+=eol:$            " End of line

set backspace=indent,eol,start  " Backspace over everything in Insert mode

set noshowmatch                 " Don't jump to matching characters
set matchpairs=(:),[:],{:},<:>  " Character pairs for use with %, 'showmatch'
set matchtime=1                 " In milliseconds, when showmatch is on

set wildmenu                    " Use menu for completions
set wildmode=full

if has("win32")
    set grepprg=internal        " Windows findstr.exe just isn't good enough.
endif


" Set 'selection', 'selectmode', 'mousemodel' and 'keymodel' to make
" both keyboard- and mouse-based highlighting behave more like Windows
" and OS X. (These are the same settings you get with `:behave mswin`.)
"
" XXX: 'selectmode' and 'keymodel' are important for some of the key mappings
" defined below. Note the specific mappings below.
"
" XXX: The MacVim HIG settings also set 'selectmode' and 'keymodel' (though,
" luckily, in exactly the same way as `:behave mswin`). Even so, consider
" breaking these out based on platform.
"
set selection=exclusive
set selectmode=mouse,key
set mousemodel=popup
set keymodel=startsel,stopsel


"
" Backup files and directories
"

" Keep a backup file for all platforms except VMS. (VMS supports automatic
" versioning.)
"
if has("vms")
    set nobackup
else
    set backup
endif

" Prepend OS-appropriate temporary directories to the backupdir list.
"
if has("unix") " (including OS X)

    " Remove the current directory from the backup directory list.
    "
    set backupdir-=.

    " Save backup files in the current user's ~/tmp directory, or in the
    " system /tmp directory if that's not possible.
    "
    set backupdir^=~/tmp,/tmp

    " Try to put swap files in ~/tmp (using the munged full pathname of
    " the file to ensure uniqueness). Use the same directory as the
    " current file if ~/tmp isn't available.
    "
    set directory=~/tmp//,.

elseif has("win32")

    " Remove the current directory from the backup directory list.
    "
    set backupdir-=.

    " Save backup files in the current user's TEMP directory
    " (that is, whatever the TEMP environment variable is set to).
    "
    set backupdir^=$TEMP

    " Put swap files in TEMP, too.
    "
    set directory=$TEMP\\\\

endif


" Switch on syntax highlighting when the terminal has colors, or when running
" in the GUI. Set the do_syntax_sel_menu flag to tell $VIMRUNTIME/menu.vim
" to expand the syntax menu.
"
" Note: This happens before the 'Autocommands' section below to give the syntax
" command a chance to trigger loading the menus (vs. letting the filetype
" command do it). If do_syntax_sel_menu isn't set beforehand, the syntax menu
" won't get populated.
"
if &t_Co > 2 || has("gui_running")
    let do_syntax_sel_menu=1
    syntax on
endif


"
" Autocommands
"

if has("autocmd") && !exists("autocommands_loaded")

    " Set a flag to indicate that autocommands have already been loaded,
    " so we only do this once. I use this flag instead of just blindly
    " running `autocmd!` (which removes all autocommands from the
    " current group) because `autocmd!` breaks the syntax highlighting /
    " syntax menu expansion logic.
    "
    let autocommands_loaded = 1

    " Enable filetype detection, so language-dependent plugins, indentation
    " files, syntax highlighting, etc., are loaded for specific filetypes.
    "
    " Note: See $HOME/.vim/ftplugin and $HOME/.vim/after/ftplugin for
    " most local filetype autocommands and customizations.
    "
    filetype plugin indent on

    " When editing a file, always jump to the last known cursor
    " position. Don't do it when the position is invalid or when inside
    " an event handler (happens when dropping a file on gvim).
    "
    autocmd BufReadPost *
        \   if line("'\"") > 0 && line("'\"") <= line("$") |
        \       exe "normal g`\"" |
        \   endif

    " Create the hook for the per-window configuration. Both WinEnter
    " and VimEnter are used, since WinEnter doesn't fire for the first
    " window.
    "
    " Based on ideas from here:
    " http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
    "
    autocmd WinEnter,VimEnter * call ConfigureWindow()

endif " has("autocmd")


"
" Key mappings
"

" These settings are taken from the $VIMRUNTIME/mswin.vim file, which is
" normally used to make Vim behave more like a native MS-Windows
" application. I don't source that file any longer, but I still want
" some of the mappings when running in Windows. (Mappings that I always
" want, regardless of platform, are below this conditional.)
"
if has("win32")

    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X>      "+x
    vnoremap <S-Del>    "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C>      "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>           "+gP
    map <S-Insert>      "+gP

    cmap <C-V>          <C-R>+
    cmap <S-Insert>     <C-R>+

    " Pasting blockwise and linewise selections is not possible in Insert and
    " Visual mode without the +virtualedit feature.  They are pasted as if
    " they were characterwise instead. Uses the paste.vim autoload script.
    "
    exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

    imap <S-Insert>     <C-V>
    vmap <S-Insert>     <C-V>

    " For CTRL-V to work autoselect must be off.
    " On Unix we have two selections, autoselect can be used.
    "
    if !has("unix")
        set guioptions-=a
    endif

    " Use CTRL-Q to do what CTRL-V used to do
    "
    noremap <C-Q>       <C-V>

    " CTRL-F4 is Close window
    "
    noremap  <C-F4>     <C-W>c
    inoremap <C-F4>     <C-O><C-W>c
    cnoremap <C-F4>     <C-C><C-W>c
    onoremap <C-F4>     <C-C><C-W>c

    " Control+Tab moves to the next window.
    "
    noremap  <C-Tab>    <C-W>w
    inoremap <C-Tab>    <C-O><C-W>w
    cnoremap <C-Tab>    <C-C><C-W>w
    onoremap <C-Tab>    <C-C><C-W>w

    " Alt-Space is System menu
    "
    if has("gui")
        noremap  <M-Space> :simalt ~<CR>
        inoremap <M-Space> <C-O>:simalt ~<CR>
        cnoremap <M-Space> <C-C>:simalt ~<CR>
    endif

endif " has("win32")

" Backspace in Visual mode deletes selection.
"
vnoremap <BS> d

" Control+A is Select All.
"
noremap  <C-A>  gggH<C-O>G
inoremap <C-A>  <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A>  <C-C>gggH<C-O>G
onoremap <C-A>  <C-C>gggH<C-O>G
snoremap <C-A>  <C-C>gggH<C-O>G
xnoremap <C-A>  <C-C>ggVG

" Control+S saves the current file (if it's been changed).
"
noremap  <C-S>  :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" Control+Z is Undo, in Normal and Insert mode.
"
noremap  <C-Z>  u
inoremap <C-Z>  <C-O>u

" Control+Y is Redo (but not repeat) in Normal and Insert mode.
"
noremap  <C-Y>  <C-R>
inoremap <C-Y>  <C-O><C-R>

" F2 inserts the date and time at the cursor.
"
inoremap <F2>   <C-R>=strftime("%c")<CR>
nmap     <F2>   a<F2><Esc>

" F7 formats the current/highlighted paragraph.
"
" XXX: Consider changing this to gwap to maintain logical cursor position.
"
nnoremap <F7>   gqap
inoremap <F7>   <C-O>gqap
vnoremap <F7>   gq

" Shift+F7 joins all lines of the current paragraph or highlighted block
" into a single line.
"
nnoremap <S-F7>  vipJ
inoremap <S-F7>  <Esc>vipJi
vnoremap <S-F7>  J

" Tab/Shift+Tab indent/unindent the highlighted block (and maintain the
" highlight after changing the indentation). Works for both Visual and Select
" modes.
"
vmap <Tab>    >gv
vmap <S-Tab>  <gv

" Map arrows/home/end keys (with and without modifiers).
"
runtime map_movement_keys.vim

" Disable paste-on-middle-click.
"
map  <MiddleMouse>    <Nop>
map  <2-MiddleMouse>  <Nop>
map  <3-MiddleMouse>  <Nop>
map  <4-MiddleMouse>  <Nop>
imap <MiddleMouse>    <Nop>
imap <2-MiddleMouse>  <Nop>
imap <3-MiddleMouse>  <Nop>
imap <4-MiddleMouse>  <Nop>

" Control+Backslash toggles search/match highlighting, 'list', and
" 'cursorline'. Note the :execute (vs. :call); see ToggleHighlight()
" for details.
"
runtime toggle_highlights.vim
map  <silent> <C-Bslash>  :execute ToggleHighlights()<CR>
imap <silent> <C-BSlash>  <Esc><C-BSlash>a
vmap <silent> <C-BSlash>  <Esc><C-BSlash>gv

" Control+Hyphen (yes, I know it says underscore) repeats the character above
" the cursor.
"
inoremap <C-_>  <C-Y>

" Center the display line after searches. (This makes it *much* easier to see
" the matched line.)
"
" More info: http://www.vim.org/tips/tip.php?tip_id=528
"
nnoremap n   nzz
nnoremap N   Nzz
nnoremap *   *zz
nnoremap #   #zz
nnoremap g*  g*zz
nnoremap g#  g#zz


" Draw lines of dashes or equal signs based on the length of the line
" immediately above.
"
"   k       Move up 1 line
"   yy      Yank whole line
"   p       Put line below current line
"   ^       Move to beginning of line
"   v$      Visually highlight to end of line
"   r-      Replace highlighted portion with dashes / equal signs
"   j       Move down one line
"   a       Return to Insert mode
"
" XXX: Convert this to a function and make the symbol a parameter.
" XXX: Consider making abbreviations/mappings for ---<CR> and ===<CR>
"
inoremap <C-U>- <Esc>kyyp^v$r-ja
inoremap <C-U>= <Esc>kyyp^v$r=ja

" Comma+SingleQuote toggles single/double quoting of the current string.
"
" XXX: Consider replacing with surround.vim plugin.
"
runtime switch_quotes.vim
nnoremap <silent> ,'  :call SwitchQuotesOnCurrentString()<CR>

" Define maps to set the filetype for the current buffer to JavaScript (for
" syntax highlighting), then format the current buffer as indented JSON.
"
" For visual mode, just format without setting the filetype. (This allows
" for easy formatting of JSON included in a non-JSON file.)
"
" Note: Requires ~/bin/format-json.pl filter.
"
nnoremap ,j  :set filetype=javascript<CR>:%!~/bin/format-json.pl<CR>
xnoremap ,j  :!~/bin/format-json.pl<CR>

" Edit user's vimrc and gvimrc in new tabs.
"
nnoremap ,ev  :tabedit $MYGVIMRC<CR>:tabedit $MYVIMRC<CR>

" Make page-forward and page-backward work in insert mode.
"
imap <C-F>  <C-O><C-F>
imap <C-B>  <C-O><C-B>

" Insert spaces to match spacing on first previous non-blank line.
"
runtime insert_matching_spaces.vim
imap <expr> <S-Tab>  InsertMatchingSpaces()

" Keep the working line in the center of the window. This is a toggle, so you
" can bounce between centered-working-line scrolling and normal scrolling by
" issuing the keystroke again.
"
" From this message on the MacVim mailing list:
" http://groups.google.com/group/vim_mac/browse_thread/thread/31876ef48063e487/133e06134425bda1?hl=en¿e06134425bda1
"
map <Leader>zz  :let &scrolloff=999-&scrolloff<CR>

" Toggle wrapping the display of long lines (and display the current 'wrap'
" state once it's been toggled).
"
nnoremap <Leader>w  :set invwrap<BAR>set wrap?<CR>

" Load the functions used by the literal-search mappings below.
"
runtime search_enhancements.vim

" Map Control+G in command-line mode to allow the user to enter
" a string that, once the user presses Enter, will be automatically
" converted to a 'literal pattern' -- that is, a pattern with
" all metacharacters and slashes and backslashes already escaped.
"
" (See notes in GetLiteralPattern() for an explanation of why this isn't an
" <expr> mapping.)
"
cmap <C-G>  <C-R><C-R>=GetLiteralPattern()<CR>

" Search for the current visually-highlighted text. The text is automatically
" escaped as with the <C-G> cmap above.
"
" Note: This overwrites the @v register.
"
xnoremap /  "vy/<C-R><C-R>=StringToPattern(@v)<CR>
xnoremap ?  "vy?<C-R><C-R>=StringToPattern(@v)<CR>

" Make * and # act similar to their normal-mode versions, but for the
" visually-highlighted text. Note that these two mappings build on the / and ?
" mappings above.
"
xmap *  /<CR>
xmap #  ?<CR>

" Toggle the NERD Tree window
"
nnoremap ,. :NERDTreeToggle<CR>

" Toggle the Taglist window
"
nnoremap <Leader>l :TlistToggle


"
" Commands
"

" View differences between the current buffer and the original file.
" (Based on code from $VIMRUNTIME/vimrc_example.vim.)
"
if !exists(":DiffOrig")
    command DiffOrig vertical new | set buftype=nofile | read # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Define commands to redirect mesages to a new buffer, window, or tab.
"
runtime redir_messages.vim

" Define the syntax-sensitive search commands, :SearchInside and :SearchOutside.
"
runtime search_with_skip.vim


" Abbreviations
"
runtime set_abbreviations.vim


"
" Extension settings (plugins, syntax files, etc.)
"

" Perl syntax
"
let perl_include_pod = 1
" unlet perl_want_scope_in_variables
" unlet perl_extended_vars
let perl_string_as_statement = 1
" unlet perl_no_sync_on_sub
" unlet perl_no_sync_on_global_var
" let perl_sync_dist = 100
let perl_fold = 1
let perl_fold_blocks = 1
" let perl_nofold_packages = 1
" let perl_nofold_subs = 1


" NERD Tree
"
let NERDChristmasTree=0
let NERDTreeHighlightCursorline=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=40


" Taglist
"
" XXX: Set the correct pathname for Windows.
"
if has("unix")
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
elseif has("win32")
    let Tlist_Ctags_Cmd = 'ctags.exe'
endif

let Tlist_Use_Right_Window = 1



"
" Functions
"

function! ConfigureWindow()

    " Only do this once per window.
    "
    if exists('w:windowConfigured')
        return
    endif

    let w:windowConfigured = 1

    " Highlight trailing whitespace.
    " (Idea from http://daniel-werner.info/vimrc.html)
    "
    "call matchadd('NonText', '\s\+$\| \+\ze\t')

    " Highlight my initials and Michele's initials as to-do markers.
    "
    call matchadd('Todo', 'WNO:')
    call matchadd('Todo', 'MRB:')

endfunction


" end .vimrc
