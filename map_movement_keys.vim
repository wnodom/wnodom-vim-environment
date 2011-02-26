" map_movement_keys.vim
"
" XXX: This file is being rebuilt. Lines after `finish` are ignored.
"

"""
""" Unshifted Up/Down, Home/End, Command+Left/Right
"""

" Normal mode
"
nnoremap <Up>       gk
nnoremap <Down>     gj

" Insert mode
"
inoremap <Up>       <C-O>gk
inoremap <Down>     <C-O>gj

" Visual mode
"
" Arrow keys leave Visual mode and move up/down one display line.
"
xnoremap <Up>       <Esc>gk
xnoremap <Down>     <Esc>gj

" Select mode
"
" Arrow keys leave Select mode and move up/down one display
" line, just like Visual mode.
"
snoremap <Up>       <Esc>gk
snoremap <Down>     <Esc>gj


"" Home/End, Command+Left/Right

" Normal mode
"
nnoremap <Home>         g0
nnoremap <End>          g$
nnoremap <D-Left>       g0
nnoremap <D-Right>      g$

" Insert mode
" 
" Piggyback on Normal-mode maps.
"
imap    <Home>          <C-O><Home>
imap    <End>           <C-O><End>
imap    <D-Left>        <C-O><D-Left>
imap    <D-Right>       <C-O><D-Right>

" Visual mode
"
" Unshifted Home/End leave Visual mode and trigger the Normal mode map.
"
xmap    <Home>          <Esc><Home>
xmap    <End>           <Esc><End>
xmap    <D-Left>        <Esc><D-Left>
xmap    <D-Right>       <Esc><D-Right>

" Select mode
"
" Unshifted Home/End leave Select mode and trigger the Normal mode map.
"
smap    <Home>          <Esc><Home>
smap    <End>           <Esc><End>
smap    <D-Left>        <Esc><D-Left>
smap    <D-Right>       <Esc><D-Right>


"""
""" Shifted Up/Down, Home/End
"""

" Make shifted up/down enter Visual mode, then move
" up/down by a display line.

" Normal mode
"
nnoremap <S-Up>     vgk
nnoremap <S-Down>   vgj

" Insert mode
"
imap    <S-Up>      <C-O><S-Up>
imap    <S-Down>    <C-O><S-Down>

" Visual mode
"
xmap    <S-Up>      gk
xmap    <S-Down>    gj

" Select mode
"
" Shift+Up/Down in Select mode enter Visual mode for one command, move the
" cursor one display line in the proper direction, then re-enter Select mode.
"
snoremap <S-Down>   <C-O>gj
snoremap <S-Up>     <C-O>gk


" Shift+Home/End, Shift+Command+Left/Right - Enter Visual mode and move
" to the start/end of the display line.

" Normal mode
"
nnoremap <S-Home>       vg0
nnoremap <S-End>        vg$
nnoremap <S-D-Left>     vg0
nnoremap <S-D-Right>    vg$

" Insert mode
"
" Leave Insert mode and trigger the Normal mode maps
"
imap <S-Home>       <Esc><S-Home>
imap <S-End>        <Esc><S-End>
imap <S-D-Left>     <Esc><S-Home>
imap <S-D-Right>    <Esc><S-End>

" Visual mode
"
xnoremap <S-Home>       g0
xnoremap <S-End>        g$
xnoremap <S-D-Left>     g0
xnoremap <S-D-Right>    g$

" Select mode
"
" Shift+Home/End in Select mode enter Visual mode for one command, move the
" cursor within the display line in the proper direction, then re-enter
" Select mode.
"
smap <S-Home>       <C-O><S-Home>
smap <S-End>        <C-O><S-End>
smap <S-D-Left>     <C-O><S-D-Left>
smap <S-D-Right>    <C-O><S-D-Right>


finish

"""""""""""""""""""""""""""""""""""""""

" map_movement_keys.vim
"
" Do all the weird stuff I have to do to make arrow/home/end/etc. keys
" (and their shifted variants) work the way that I want them to.
"
" XXX: Much of this is still a work in progress.
"
" Note: The 'standard' movement keys (h j k l ^ 0 $) are left as-is,
" so it's always possible to use them to do what they should do.
"

" Note: These options are also set by the :behave command.
" 
set selectmode+=key
set keymodel=startsel,stopsel


" Control+Up/Down move lines and selections up and down.
" Based on http://vim.wikia.com/wiki/VimTip646
" 
" Define maps for Normal and Visual modes, then re-use
" them for Insert and Select.
"
nnoremap <silent>  <C-Up>    :move -2<CR>
nnoremap <silent>  <C-Down>  :move +<CR>
xnoremap <silent>  <C-Up>    :move '<-2<CR>gv
xnoremap <silent>  <C-Down>  :move '>+<CR>gv
imap     <silent>  <C-Up>    <C-O><C-Up>
imap     <silent>  <C-Down>  <C-O><C-Down>
smap     <silent>  <C-Up>    <C-G><C-Up><C-G>
smap     <silent>  <C-Down>  <C-G><C-Down><C-G>


" Make arrow keys and Home/End (and their Select-mode-triggering
" shifted versions) move by display lines instead of physical lines.
"
" TODO:
" - Consider what PgUp/PgDn (with shift, control, etc.) should do.
" - Behavior on long lines under `:set nowrap` is strange. May want to
"   activate some or all of these only when 'wrap' is set.
"

" Make (unshifted) arrow keys move by display lines instead of physical lines.
"
inoremap <Up>     <C-O>gk
inoremap <Down>   <C-O>gj
"
nnoremap <Up>     gk
nnoremap <Down>   gj
"
xnoremap <Up>     gk
xnoremap <Down>   gj
xnoremap <Left>   h
xnoremap <Right>  l






" Make shifted arrows keys ignore soft-wrapping, too. This requires a little
" more trickery.
"
" Notes:
" - These mappings require that 'selectmode' contains 'key' and that
"   keymodel=startsel,stopsel (so Vim can do most of the heavy lifting on
"   entering and leaving Select mode, and I can just do a little tweaking
"   with these maps).
" - This is still experimental. It's worked great for the 10 minutes I've
"   tested it, but I'll be surprised if there aren't some edge cases waiting
"   to surprise me.
"

if 0
    nunmap <S-Down>
    nunmap <S-Up>
    nunmap <S-Left>
    nunmap <S-Right>
    sunmap <S-Down>
    sunmap <S-Up>
    sunmap <S-Left>
    sunmap <S-Right>
endif


" Shift+Up/Down in Normal mode start Select mode and move the cursor one
" display line the proper direction.
"
nnoremap <S-Down>   gh<C-O>gj
nnoremap <S-Up>     gh<C-O>gk

" Shift+Up/Down in Select mode enter Visual mode for one command, move the
" cursor one display line in the proper direction, then re-enter Select mode.
"
snoremap <S-Down>   <C-O>gj
snoremap <S-Up>     <C-O>gk

" Up/Down in Select mode exit Select mode, then move the cursor one display
" line in the proper direction.
"
snoremap <Down>     <Esc>gj
snoremap <Up>       <Esc>gk

" These mappings are unecessary if keymodel is set properly, and they break
" wrapping around start/end of line... so I don't set 'em. They're just noted
" here so I don't forget why they're not set.
"
"nnoremap <S-Left>   gh<C-O>h
"nnoremap <S-Right>  gh<C-O>l
"snoremap <S-Left>   <C-O>h
"snoremap <S-Right>  <C-O>l

" Home/End mappings, and their Mac equivalents
"
" XXX: The Command+Left/Right arrows are Mac-specific, and should probably be
" set off as such. Similarly, the Home/End versions need to be tested on
" systems that, unlike my laptop, actually have those keys.
"

" Go to the start/end of the display line.
"
nnoremap <Home>         g0
nnoremap <D-Left>       g0

nnoremap <End>          g$
nnoremap <D-Right>      g$

" inoremap <Home>         <C-O>g0
" inoremap <D-Left>       <C-O>g0
" 
" inoremap <End>          <C-O>g$
" inoremap <D-Right>      <C-O>g$


" Enter Select mode, then go to the start/end of the display line.
"
nnoremap <S-D-Left>     gh<C-O>g0
nnoremap <S-Home>       gh<C-O>g0
nnoremap <S-D-Right>    gh<C-O>g$
nnoremap <S-End>        gh<C-O>g$

" Extend the selection to the start/end of the display line.
"
snoremap <S-Home>       <C-O>g0
snoremap <S-D-Left>     <C-O>g0
snoremap <S-End>        <C-O>g$
snoremap <S-D-Right>    <C-O>g$

" Exit Select mode, then go to the start/end of the display line.
"
snoremap <Home>         <Esc>g0
snoremap <D-Left>       <Esc>g0
snoremap <End>          <Esc>g$
snoremap <D-Right>      <Esc>g$

" In Visual mode, just go the start/end of the display line.
"
xnoremap <Home>         g0
xnoremap <D-Left>       g0
xnoremap <End>          g$
xnoremap <D-Right>      g$

" XXX: DISABLED (at least temporarily)
"
if 0

" Don't let MacVim map the Command/Option movement keys
"
let macvim_skip_cmd_opt_movement=1

" Don't let MacVim enable HIG shift movement settings.
unlet! macvim_hig_shift_movement

endif " 0 - disabled


" Enable Human-Interface Guidelines (HIG) command/option/shift movement
" keys in MacVim. (See MacVim.app/Contents/Resources/vim/gvimrc for details.)
"
" Note: It might seem like these flags should go in the user's gvimrc, since
" they're related to the GUI, but that's not correct. They're checked by
" MacVim's system gvimrc, which runs before the user's gvimrc, so if they're
" not here, they don't get set in time.
"
if has("gui_macvim")

    " Enable HIG Command and Option movement mappings.
    " by *not* setting macvim_skip_cmd_opt_movement.
    " (That is, *don't* skip mapping them.)
    "
    unlet! macvim_skip_cmd_opt_movement

    " Enable HIG shift movement settings.
    let macvim_hig_shift_movement=1

endif " has("gui_macvim")



" XXX: This block of dead code is copied from MacVim's system gvimrc, so I can
" easily see what it does while I'm troubleshooting my own meta+arrow mappings
" above. It'll go away once that's complete.
"
" (The real version of this code runs after the user's vimrc and before the
" user's gvimrc.)
"
" no    = noremap
" no!   = noremap!
"
" The ':map' command creates a key map that works in normal, visual, select
" and operator pending modes. The ':map!' command creates a key map that works
" in insert and command-line mode.
"
"    :no[remap]  {lhs} {rhs}		|mapmode-nvo|		*:no*  *:noremap*
"    :nn[oremap] {lhs} {rhs}		|mapmode-n|		*:nn*  *:nnoremap*
"    :vn[oremap] {lhs} {rhs}		|mapmode-v|		*:vn*  *:vnoremap*
"    :xn[oremap] {lhs} {rhs}		|mapmode-x|		*:xn*  *:xnoremap*
"    :snor[emap] {lhs} {rhs}		|mapmode-s|		*:snor* *:snoremap*
"    :ono[remap] {lhs} {rhs}		|mapmode-o|		*:ono* *:onoremap*
"    :no[remap]! {lhs} {rhs}		|mapmode-ic|		*:no!* *:noremap!*
"    :ino[remap] {lhs} {rhs}		|mapmode-i|		*:ino* *:inoremap*
"    :ln[oremap] {lhs} {rhs}		|mapmode-l|		*:ln*  *:lnoremap*
"    :cno[remap] {lhs} {rhs}		|mapmode-c|		*:cno* *:cnoremap*
"                Map the key sequence {lhs} to {rhs} for the modes
"                where the map command applies.  Disallow mapping of
"                {rhs}, to avoid nested and recursive mappings.  Often
"                used to redefine a command.  {not in Vi}
" 
if 0


" This is so that HIG Cmd and Option movement mappings can be disabled by
" adding the line
"   let macvim_skip_cmd_opt_movement = 1
" to the user .vimrc
"
if !exists("macvim_skip_cmd_opt_movement")
            noremap   <D-Left>       <Home>
            noremap!  <D-Left>       <Home>
  noremap   <M-Left>       <C-Left>
  noremap!  <M-Left>       <C-Left>

            noremap   <D-Right>      <End>
            noremap!  <D-Right>      <End>
  noremap   <M-Right>      <C-Right>
  noremap!  <M-Right>      <C-Right>

  noremap   <D-Up>         <C-Home>
  inoremap  <D-Up>         <C-Home>
  map       <M-Up>         {
  imap      <M-Up>         <C-o>{

  noremap   <D-Down>       <C-End>
  inoremap  <D-Down>       <C-End>
  map       <M-Down>       }
  imap      <M-Down>       <C-o>}
endif " !exists("macvim_skip_cmd_opt_movement")


" This is so that the HIG shift movement related settings can be enabled by
" adding the line
"   let macvim_hig_shift_movement = 1
" to the user .vimrc (not .gvimrc!).
"
if exists("macvim_hig_shift_movement")
  " Shift + special movement key (<S-Left>, etc.) and mouse starts insert mode
  set selectmode=mouse,key
  set keymodel=startsel,stopsel

  " HIG related shift + special movement key mappings
            nnoremap   <S-D-Left>     <S-Home>
  vnoremap   <S-D-Left>     <S-Home>
  inoremap   <S-D-Left>     <S-Home>
  nnoremap   <S-M-Left>     <S-C-Left>
  vnoremap   <S-M-Left>     <S-C-Left>
  inoremap   <S-M-Left>     <S-C-Left>

  nnoremap   <S-D-Right>    <S-End>
  vnoremap   <S-D-Right>    <S-End>
  inoremap   <S-D-Right>    <S-End>
  nnoremap   <S-M-Right>    <S-C-Right>
  vnoremap   <S-M-Right>    <S-C-Right>
  inoremap   <S-M-Right>    <S-C-Right>

  nnoremap   <S-D-Up>       <S-C-Home>
  vnoremap   <S-D-Up>       <S-C-Home>
  inoremap   <S-D-Up>       <S-C-Home>

  nnoremap   <S-D-Down>     <S-C-End>
  vnoremap   <S-D-Down>     <S-C-End>
  inoremap   <S-D-Down>     <S-C-End>
endif " exists("macvim_hig_shift_movement")



endif " 0

" end map_movement_keys.vim
