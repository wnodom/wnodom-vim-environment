" configure_signs.vim
"
" Set up an autocommand to always show the signs column, to keep
" the display from shifting left and right when signs are
" shown/hidden.
"

sign define dummy_sign_to_keep_sign_column_visible

" Build a lookup table of the filetypes that shouldn't have an always-visible
" sign column.
"
let s:filetypes_to_avoid_string = 'help qf nerdtree text'
let s:filetypes_to_avoid = {}
for s:ft in split(s:filetypes_to_avoid_string)
  let s:filetypes_to_avoid[s:ft] = 1
endfor

" XXX: Consider checking &buftype as well.
"
autocmd FileType *
\ if !has_key(s:filetypes_to_avoid, &filetype) |
\     execute 'sign place 9999 line=1 name=dummy_sign_to_keep_sign_column_visible buffer=' . bufnr('') |
\ endif

" end configure_signs.vim
