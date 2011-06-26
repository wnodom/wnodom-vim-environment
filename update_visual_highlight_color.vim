" update_visual_highlight_color.vim
"
" Experimental script to change the 'Visual' highlight group
" to different values depending on whether we're in 'Select' mode
" or not.
"
" To use, copy this script to ~/.vim and add lines like these
" to your .vimrc:
"
"   runtime update_visual_highlight_color.vim
"   set statusline+=%{UpdateVisualHighlightColor()}
"
" TODO:
" - Link to existing highlight groups (possibly predefined by the user)
"   instead of hard-coding guifg and guibg.
" - Consider converting to a plugin, with real documentation.
" - Handle Visual Block mode.
"

function! UpdateVisualHighlightColor(xm)

    " Grab the short version of the current mode,
    " and convert it to uppercase so we don't have to
    " worry about the characterwise vs. linewise sub-modes.
    "
    " XXX: This doesn't handle Visual Block mode.
    "
    let l:m = toupper(a:xm)

    if l:m ==# "S"
        highlight Visual guifg=#3c6182 guibg=White
        redraw
    elseif l:m ==# "V"
        highlight Visual guifg=White guibg=#3c6182
        redraw
    endif

    " Don't contribute anything to the statusline. This
    " is all about the side effects.
    "
    return ""

endfunction

" end update_visual_highlight_color.vim
