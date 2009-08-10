" diff_with_saved.vim

function! DiffWithSaved()
"
" Diff saved version of file with the current buffer. Call with
" :DiffSaved (defined immediately below), and exit with the :diffoff
" command
"
" From http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
"
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype

endfunction

" end diff_with_saved.vim
