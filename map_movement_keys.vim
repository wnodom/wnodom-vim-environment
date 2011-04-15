" map_movement_keys.vim
"
" Do all the weird stuff I have to do to make arrow/home/end/etc. keys (and
" their shifted variants) move by display lines instead of physical lines.
"
" Note: The 'standard' movement keys (h j k l ^ 0 $) are left as-is,
" so it's always possible to use them to do what they should do.
"
" Note: There's no need to map Shift+Left/Right to enter Select mode if
" keymodel contains `startsel,stopsel` (and doing so breaks wrapping around
" start/end of line), so I don't do it.
"
" TODO:
" 
" - Add Shift+Option maps (possibly as a way to activate Visual mode).
"
" - Behavior on long lines under `:set nowrap` is strange. May want to
"   activate some or all of these only when 'wrap' is set.
" 
" - Consider what PgUp/PgDn (with shift, control, etc.) should do.
" 
" - Command-key maps are Mac-specific, and should probably be
"   set off as such.
" 
" - Home/End maps need to be tested on systems that, unlike my laptop,
"   actually have those keys.
"


" Set selectmode and keymodel appropriately, as these mappings
" depend on it.
"
" Note: These options are also set by the :behave command,
" and within the MacVim internal gvimrc depending on the
" values of flag variables (see below).
"
set selectmode=key,mouse
set keymodel=startsel,stopsel

" Configure HIG-related options for MacVim.
" (See MacVim.app/Contents/Resources/vim/gvimrc for details.)
"
" Note: It might seem like these flags should go in the user's gvimrc, since
" they're related to the GUI, but that's not correct. They're checked by
" MacVim's system gvimrc, which runs before the user's gvimrc. If they're not
" set before the MacVim gvimrc is processed, they don't affect MacVim's
" behavior.

" Don't allow the MacVim internal gvimrc to create the HIG
" Command and Option movement mappings.
"
let macvim_skip_cmd_opt_movement = 1

" Don't have MacVim enable the HIG Shift movement-related
" settings, either.
"
unlet! macvim_hig_shift_movement


"""
""" Unshifted Up/Down, Home/End, Command+Left/Right
"""

"" Up/Down

" Normal mode
"
nnoremap <Up>           gk
nnoremap <Down>         gj

" Insert mode
"
inoremap <Up>           <C-O>gk
inoremap <Down>         <C-O>gj

" Visual mode
"
" Arrow keys leave Visual mode and move up/down one display line.
"
xnoremap <Up>           <Esc>gk
xnoremap <Down>         <Esc>gj

" Select mode
"
" Arrow keys leave Select mode and move up/down one display
" line, just like Visual mode.
"
snoremap <Up>           <Esc>gk
snoremap <Down>         <Esc>gj


"" Unshifted Home/End, Command+Left/Right

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
""" Shifted Up/Down, Home/End, Command+Left/Right
"""

" Make shifted up/down enter Select mode, then move
" up/down by a display line.

" Normal mode
"
" Enter Select mode, switch to Visual mode for a single
" command, then move.
"
nnoremap <S-Down>       gh<C-O>gj
nnoremap <S-Up>         gh<C-O>gk

" Alternative - enter Visual mode, move, then switch to Select mode:
"
"   nnoremap <S-Up>         vgk<C-G>
"   nnoremap <S-Down>       vgj<C-G>
"

" Insert mode
"
imap    <S-Up>          <C-O><S-Up>
imap    <S-Down>        <C-O><S-Down>

" Visual mode
"
" XXX: Should shifted keys switch from Visual mode to Select mode, or stay in
" Visual mode? For now, they stay in Visual mode.
"
xmap    <S-Up>          gk
xmap    <S-Down>        gj

" Select mode
"
" Shift+Up/Down in Select mode enter Visual mode for one command, move the
" cursor one display line in the proper direction, then re-enter Select mode.
"
snoremap <S-Down>       <C-O>gj
snoremap <S-Up>         <C-O>gk


" Shift+Home/End, Shift+Command+Left/Right - Enter Visual mode and move
" to the start/end of the display line, then switch to Select mode.

" Normal mode
"
" Enter Select mode, switch to Visual mode for a single
" command, then move.
"
nnoremap <S-Home>       gh<C-O>g0
nnoremap <S-End>        gh<C-O>g$
nnoremap <S-D-Left>     gh<C-O>g0
nnoremap <S-D-Right>    gh<C-O>g$

" Alternative - enter Visual mode, move, then switch to Select mode:
"
"   nnoremap <S-Home>       vg0<C-G>
"   nnoremap <S-End>        vg$<C-G>
"   nnoremap <S-D-Left>     vg0<C-G>
"   nnoremap <S-D-Right>    vg$<C-G>


" Insert mode
"
" Leave Insert mode for a single command, then trigger the Normal mode
" maps.
"
" Note: Watch out for a possible bug. When the Normal-mode maps enter Visual
" mode (instead of Select mode), the cursor doesn't land in the right place.
" It stops a few characters from the beginning of the line, for example, or
" wraps around to the next line when attempting to go to the end. When the
" Normal-mode maps are built for Select mode, as they are now, it works fine.
"
imap <S-Home>           <C-O><S-Home>
imap <S-End>            <C-O><S-End>
imap <S-D-Left>         <C-O><S-Home>
imap <S-D-Right>        <C-O><S-End>

" Alternative - leave Insert mode entirely and trigger the Normal mode maps:
"
"   imap <S-Home>           <Esc><S-Home>
"   imap <S-End>            <Esc><S-End>
"   imap <S-D-Left>         <Esc><S-Home>
"   imap <S-D-Right>        <Esc><S-End>
"
" Note: This works, but doesn't properly remain in [ (insert) Visual ] mode,
" which means it doesn't return to Insert mode when leaving Visual mode. This
" may not be a big deal, but it feels weird in practice.


" Visual mode
"
xnoremap <S-Home>       g0
xnoremap <S-End>        g$
xnoremap <S-D-Left>     g0
xnoremap <S-D-Right>    g$

" Select mode
"
" Extend the selection to the start/end of the display line.
"
" Shift+Home/End in Select mode enter Visual mode for one command, move the
" cursor within the display line in the proper direction, then re-enter
" Select mode.
"
" XXX: These require that the corresponding Visual mode maps all be single
" commands.
"
smap <S-Home>           <C-O><S-Home>
smap <S-End>            <C-O><S-End>
smap <S-D-Left>         <C-O><S-D-Left>
smap <S-D-Right>        <C-O><S-D-Right>


"""
""" TODO: Shift+Option Up/Down, Home/End, Command+Left/Right
"""




" end map_movement_keys.vim
