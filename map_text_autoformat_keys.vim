" Add  these  lines  to  your  .vimrc  and  you  will  be   happy   with
" p5-Text-Autoformat. Use ctrl-k to reformat a paragraph and  ctrl-n  to
" reformat all text from the cursor.

imap <C-K> <esc> !G perl -MText::Autoformat -e "{autoformat;}"<cr>
nmap <C-K>       !G perl -MText::Autoformat -e "{autoformat;}"<cr>
vmap <C-K>       !G perl -MText::Autoformat -e "{autoformat;}"<cr>

imap <C-N> <esc> !G perl -MText::Autoformat -e "{autoformat{all=>1};}"<cr>
nmap <C-N>       !G perl -MText::Autoformat -e "{autoformat{all=>1};}"<cr>
vmap <C-N>       !G perl -MText::Autoformat -e "{autoformat{all=>1};}"<cr>

