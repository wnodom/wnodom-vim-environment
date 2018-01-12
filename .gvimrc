" .gvimrc
"
" GUI-only Vim settings.
"

function! <SID>SetDefaultFontOptions()
"
" Defines several font and font-related options in one place, so they
" can be easily reset just by calling the function again.
"
" Note that linespace and guifont are combined into individual `set`
" statements, since different fonts look better with different line spacing.
" (They can also be set separately, but it's just more convenient to keep them
" together like this.)
"
    if has("win32")
        set guifont=Consolas:h11
    elseif has("gui_macvim")
        set antialias

        " Nerd Fonts patched with several libraries of icon and glyphs
        " https://github.com/ryanoasis/nerd-fonts
        "
        set linespace=5 guifont=M+_1m_regular_Nerd_Font_Complete_Mono:h23
    "   set linespace=2 guifont=Sauce_Code_Pro_Nerd_Font_Complete_Mono:h20

    "   set linespace=1 guifont=Andale_Mono:h15
    "   set linespace=0 guifont=Consolas:h15
    "   set linespace=0 guifont=Droid_Sans_Mono:h13
    "   set linespace=0 guifont=Inconsolata:h15
    "   set linespace=2 guifont=M+_1m_regular:h15
    "   set linespace=3 guifont=M+_1m_regular:h23
    "   set linespace=2 guifont=Source_Code_Pro:h20
    "   set linespace=2 guifont=Source_Code_Pro:h13
    "   set linespace=2 guifont=Source_Code_Pro_Light:h17
    "   set linespace=2 guifont=Menlo:h12
    "   set linespace=2 guifont=Menlo:h19
    "   set linespace=2 guifont=Menlo:h25
    "   set linespace=2 guifont=Monaco:h13
    endif

endfunction


set guioptions+=b           " Activate the bottom horizontal scrollbar
set guioptions-=T           " Turn off the toolbar

set guicursor+=a:blinkon0   " Turn off cursor blink in all modes
set guicursor+=v:ver35      " Keep the cursor from obscuring visual selections

set guitablabel=%N:\ %t\ %m " GUI tab labels show tab#, file, & modified flag
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

" Windows settings
"
if has("win32")

    call <SID>SetDefaultFontOptions()

    " Maps to restore default font settings.
    "
    nnoremap    <C-0>   :call <SID>SetDefaultFontOptions()<CR>
    imap        <C-0>   <C-O><C-0>

    " Maximize the Win32 GUI window.
    "
    if has("autocmd")
        autocmd GUIEnter * simalt ~x
    endif

endif

" MacVim (Cocoa) settings
"
if has("gui_macvim")

    call <SID>SetDefaultFontOptions()

    " Maps to restore default font settings.
    "
    nnoremap    <D-0>   :call <SID>SetDefaultFontOptions()<CR>
    imap        <D-0>   <C-O><D-0>

    " Provide OSX-style access to individual tabs.
    "
    " XXX: DRY these up with a loop, and make them available from all modes.
    "
    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
    nnoremap <D-6> 6gt
    nnoremap <D-7> 7gt
    nnoremap <D-8> 8gt
    nnoremap <D-9> 9gt

    " Make the Vim window as tall and wide as possible.
    "
    set lines=999 columns=9999

    " Maximize both horizontally and vertically when entering fullscreen mode.
    "
    " Note: I've started avoiding fullscreen mode, since it seems to make
    " MacVim crashy. Instead, I've set the Window->Zoom command
    " (Command+Control+Z) to zoom both horizontally and vertically with this
    " OS X defaults command:
    "
    "   defaults write org.vim.MacVim MMZoomBoth 1
    "
    " See :help macvim-user-defaults for more information.
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
" runtime update_visual_highlight_color.vim

" end .gvimrc
