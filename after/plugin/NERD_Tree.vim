
"let g:NERDTreeShowBookmarks = 1

" Uncomment the following lines to always show NERDTree
" when entering Vim
"
"autocmd VimEnter * NERDTree | wincmd p

" Add _instructor.md and _explanation.md files to NERDTree's
" 'Ignore' filter.
"
call extend(g:NERDTreeIgnore, [
\   '^_instructor\.md$[[file]]' ,
\   '^_explanation\.md$[[file]]'
\ ])

