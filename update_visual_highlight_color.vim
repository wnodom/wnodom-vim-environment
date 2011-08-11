" update_visual_highlight_color.vim
"
" Experimental script to change the 'Visual' highlight group to different
" values depending on whether we're in 'Select' mode or not.
"
" To use, copy this script to ~/.vim and add these lines to your .vimrc:
"
"   runtime update_visual_highlight_color.vim
"   set statusline+=%{UpdateVisualHighlightColor(mode(0))}
"
" TODO:
" - Link to existing highlight groups (possibly predefined by the user)
"   instead of hard-coding guifg and guibg.
" - Consider converting to a plugin, with real documentation.
" - Handle Visual Block mode.
" - Complete the definitions of the default highlighting groups.
"

" Define default highlighting groups used for specific Visual sub-modes.
" (These can be overridden within a colorscheme.)
"
highlight default Select            guifg=#3c6182   guibg=White
highlight default VisualOriginal    guifg=White     guibg=#3c6182


function! UpdateVisualHighlightColor(xm)

    " Grab the short version of the current mode,
    " and convert it to uppercase so we don't have to
    " worry about the characterwise vs. linewise sub-modes.
    "
    " XXX: This doesn't (yet) handle Visual Block mode.
    "
    let l:m = toupper(a:xm)

    " Link the Visual highlighting to the appropriate highlighting group
    " based on the current mode.
    "
    if l:m ==# "S"
        highlight! link Visual Select
        redraw
    elseif l:m ==# "V"
        highlight! link Visual VisualOriginal
        redraw
    endif

    " Don't contribute anything to the statusline. This
    " is all about the side effects.
    "
    return ""

endfunction

" end update_visual_highlight_color.vim
