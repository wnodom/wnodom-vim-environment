" .gvimrc
"
" GUI-only Vim settings.
"

set guioptions+=b           " Activate the bottom horizontal scrollbar
set guioptions-=T           " Turn off the toolbar

set guicursor+=a:blinkon0   " Turn off cursor blink in all modes
set guicursor+=v:ver35      " Keep the cursor from obscuring visual selections

set guitablabel=%t\ %m      " GUI tab labels show filename and modified flag
set guitabtooltip=%F        " GUI tab tooltips show the full pathname

set showtabline=1           " Show the tab line if there's more than one tab
set tabpagemax=100          " Allow many more files to be opened in tabs

" Note: If you want to control the width of the tabs in MacVim (the OS X
" Cocoa GUI version of Vim), then use these commands from the Terminal:
"
"   defaults write org.vim.MacVim MMTabMinWidth     250
"   defaults write org.vim.MacVim MMTabOptimumWidth 350
"   defaults write org.vim.MacVim MMTabMaxWidth     500
"
" The values are in pixels. Adjust as necessary for your environment.


" Avoid all beeping and flashing by turning on the visual bell, and then
" setting the visual bell to nothing.
"
" Note: Even if t_vb is set in .vimrc, it has to be set again here, as it's
" reset when the GUI starts.
"
set visualbell t_vb=


"
" Fonts, window size and position
"

" Windows settings
" 
if has("win32")

    set guifont=Consolas:h11
    " set guifont=Fixedsys

    " Maximize the Win32 GUI window.
    "
    if has("autocmd")
        autocmd GUIEnter * simalt ~x
    endif

endif

" Carbon Vim settings
" 
if has("gui_mac")

    " Workaround to improve text drawing under OS X. (Applicable to Carbon
    " gVim, but not MacVim.) See :h macatsui for details.
    "
    if exists('&macatsui')
        set nomacatsui
    endif

endif

" MacVim (Cocoa) settings
"
if has("gui_macvim")

    " Set the antialias, linespace, and guifont together, since different
    " fonts look better with different settings. (These can be set separately,
    " but it's just more convenient to keep them together like this.)
    "
    "set antialias linespace=0 guifont=Inconsolata:h15
     set antialias linespace=2 guifont=Menlo:h15
    "set antialias linespace=0 guifont=Droid_Sans_Mono:h13
    "set antialias linespace=0 guifont=Consolas:h15
    "set antialias linespace=2 guifont=Monaco:h13
    "set antialias linespace=1 guifont=Andale_Mono:h15
    "set noantialias guifont=Fixedsys_True_Type_Font:h15

    " XXX: Temporary maps to restore the predefined font settings, just as an
    " experiment. These need to be replaced with something more comprehensive
    " and robust.
    "
    nnoremap    <D-0>   :set antialias linespace=2 guifont=Menlo:h15<CR>
    imap        <D-0>   <C-O><D-0>

    " Make the Vim window as tall as possible.
    "
    set lines=999 columns=140

    " Maximize both horizontally and vertically when entering
    " fullscreen mode.
    "
    set fuoptions=maxvert,maxhorz

    set fillchars+=vert:\|,fold:•

endif

" Load my custom colorscheme.
"
colorscheme wnodom

" Turn on the experimental highlight-color-changer for Visual/Select modes.
" (This probably won't stay here, since it's not just for GUI Vim, but
" in its current state, this is the best place for it.)
"
runtime update_visual_highlight_color.vim


" end .gvimrc
