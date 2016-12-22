" selective.vim
"
" Vim plugin to do all the weird stuff I have to do to make movement keys
" (arrow/home/end/etc.) and their shifted variants move by display lines
" instead of physical lines.
"
" Notes:
"
" - The 'standard' movement keys (h j k l ^ 0 $) are left as-is, so it's
"   always possible to use them to do what they should do.
"
" - Many of these mappings use Control+O (often multiple times) to temporarily
"   change from Insert to Normal mode, or from Select to Visual mode, when it
"   might seem easier to just use Escape instead. The problem with the Escape
"   versions of the maps is that they can't respect submodes, so when the user
"   finishes highlighting, they don't return to the mode they started in. This
"   might not seem like a big deal, but it's jarring in practice.
"
" - Several of the Insert-mode maps might seem overly-complicated. Trust me,
"   there's a reason for all the complexity. I'll place a general explanation
"   here soon, but for now, see the notes above the Insert-mode map for
"   Shift+Home.
"
"
" TODO (or To-Consider):
"
" - Expand installation and usage docs.
"
" - Improve internal documentation.
"
" - Handle remaining bugs, noted in comments below.
"
" - In the MacVim gvimrc, Bjorn Winckler (maintainer of MacVim) says:
"
"     This is a work in progress.  If you feel so inclined, please help me
"     improve this file.
"
" - Consider what PgUp/PgDn (with shift, control, etc.) should do. (The
"   shifted versions already work as expected.)
"
" - Command-key maps are Mac-specific, and should probably be set off as such.
"
" - Home/End maps need to be tested on systems that, unlike my laptop,
"   actually have those keys.
"
" - Consider whether or not movement keys should exit Visual mode (like they
"   do for Select mode). They do now, but I don't know if I like it. It means
"   you can't use the arrow keys for Visual Block highlighting, for example.
"
"   Update: Tried to fix this, but it didn't work out as I thought it would.
"   The `keymodel` setting seems to cause the arrows to exit Visual mode; the
"   mappings don't matter. I'll experiment with this more later.
"
" - Consider making these maps adjust to the `selectmode` setting, so all the
"   fancy keystroke maps work for both Visual and Select modes (depending on
"   which one the user prefers).
"
" - Review the MacVim internal gvimrc for additional maps that may
"   need to be included in this plugin.
"

if exists('g:loaded_selective')
    finish
endif
let g:loaded_selective = 1


" Use the default Vim compatibility options (mostly to allow long lines
" to be continued with backslashes).
"
let s:save_cpo = &cpo
set cpo&vim


" Keep the MacVim internal gvimrc from mapping any of these keys by
" defining the HIG flag variables appropriately. (See
" MacVim.app/Contents/Resources/vim/gvimrc for more details.)
"
" Note: In previous versions of MacVim, plugins were loaded *after* the
" MacVim gvimrc, so this wasn't necessary. The system gvimrc mapped the
" keys, and this plugin just mapped them again. Apparently now plugins
" execute before the system gvimrc, which means that the gvimrc has the
" chance to overwrite our mapped keys -- unless it's told not to.
"
let g:macvim_skip_cmd_opt_movement = 1
unlet! g:macvim_hig_shift_movement


"""
""" Settings
"""

" Set selectmode, selection, and keymodel appropriately, as some of these
" mappings depend on it.
"
" Note: These options are also set by the `:behave` command, and within
" the MacVim internal gvimrc depending on the values of the HIG flag
" variables. If the keys don't do what you think they should, make sure
" you're not setting these values to unexpected values elsewhere in your
" configuration. XXX: Note this in the user documentation.
"
set selectmode=key,mouse
set selection=exclusive
set keymodel=startsel,stopsel


"""
""" Unmodified movement keys
"""

"" Left/Right

" Defaults work fine. Nothing extra to do here.


"" Up/Down

" Normal mode
"
nnoremap    <Up>                gk
nnoremap    <Down>              gj

" Insert mode
"
inoremap    <Up>                <C-O>gk
inoremap    <Down>              <C-O>gj

" Visual mode
"
" Arrow keys leave Visual mode and move up/down one display line.
"
xnoremap    <Up>                <Esc>gk
xnoremap    <Down>              <Esc>gj

" Select mode
"
" Arrow keys leave Select mode and move up/down one display line, just
" like Visual mode.
"
snoremap    <Up>                <Esc>gk
snoremap    <Down>              <Esc>gj


"" Home/End, Command+Left/Right

" Normal mode
"
" Move to the start or end of the display/physical line, depending on
" the `wrap` setting.
"
nnoremap    <expr> <Home>       &wrap ? "g0" : "0"
nnoremap    <expr> <End>        &wrap ? "g$" : "$"
nmap        <D-Left>            <Home>
nmap        <D-Right>           <End>

" Insert mode
"
" Piggyback on Normal-mode maps, but stay in Insert mode.
"
imap        <Home>              <C-O><Home>
imap        <End>               <C-O><End>
imap        <D-Left>            <C-O><Home>
imap        <D-Right>           <C-O><End>

" Visual mode
"
" Unshifted Home/End leave Visual mode and trigger the Normal mode map.
"
xmap        <Home>              <Esc><Home>
xmap        <End>               <Esc><End>
xmap        <D-Left>            <Esc><D-Left>
xmap        <D-Right>           <Esc><D-Right>

" Select mode
"
" Unshifted Home/End leave Select mode and trigger the Normal mode map.
"
smap        <Home>              <Esc><Home>
smap        <End>               <Esc><End>
smap        <D-Left>            <Esc><D-Left>
smap        <D-Right>           <Esc><D-Right>


"" Command+Up/Down

" Normal mode
"
nnoremap    <D-Up>              gg
nnoremap    <D-Down>            G

" Insert mode
"
imap        <D-Up>              <C-O><D-Up>
imap        <D-Down>            <C-O><D-Down>

" Visual mode
"
xmap        <D-Up>              <Esc><D-Up>
xmap        <D-Down>            <Esc><D-Down>

" Select mode
"
smap        <D-Up>              <Esc><D-Up>
smap        <D-Down>            <Esc><D-Down>


"""
""" Shifted movement keys
"""

"" Shift+Left/Right

" There's no need to map Shift+Left/Right to enter Select mode if
" keymodel contains `startsel,stopsel`. In fact, mapping them breaks
" wrapping around the start/end of line.


"" Shift+Up/Down

" Normal mode
"
" Enter Select mode, switch to Visual mode for a single
" command, then move.
"
nnoremap    <S-Up>              gh<C-O>gk
nnoremap    <S-Down>            gh<C-O>gj


" Insert mode
"
" Okay... I don't feel good about this technique, but it almost works.
"
" These maps start Visual mode with Shift+Up immediately followed by
" Shift+Down. This leaves the cursor in its original starting position, even
" if that's after the last character on a line, but with Visual mode active.
" (See note below about shifted arrow keys starting Visual instead of Select
" mode.)
"
" Now that Visual mode is active, the cursor is moved up or down by one
" display line (using gk or gj). Once the cursor has been moved, Vim is
" switched from Visual to Select mode with Control+G.
"
" Note: I expected the initial Shift+Right to place Vim in Select mode, but it
" ends up in Visual mode instead. I don't know if this is a Vim bug, or if my
" expectations are just incorrect. Probably needs to be tested on different
" versions to be sure.
"
" Anyway, now that I've crafted this little trick, I'm wondering if it might
" be useful in some of the other mappings. It's ugly, but arguably simpler
" than several of the stunts I have to pull elsewhere in this plugin.
"
" BUG: Argh. If the cursor starts at EOF, then we end up in the wrong mode.
" Same thing happens with Shift+Up (but not Shift+Down) at BOF. This really
" makes me think I'm running into a Vim bug. It's probably possible to
" work around this with some code that detects EOF/BOF and then does the
" right thing (whatever that might be).
"
"inoremap    <S-Up>              <S-Right><S-Left>gk<C-G>
"inoremap    <S-Down>            <S-Right><S-Left>gj<C-G>
inoremap    <S-Up>              <S-Up><S-Down>gk<C-G>
inoremap    <S-Down>            <S-Up><S-Down>gj<C-G>

" Here are the original Insert-mode Shift+Up/Down maps. Note the technique
" similar to the Insert-mode Shift+Home mapping to avoid the
" missing-last-character bug. Even with this technique, however, the maps
" still didn't quite work properly. Extra characters were sometimes selected
" when they shouldn't be, especially when dealing with uneven line lengths.
" Specifically, if the cursor moved from a longer line to a shorter line, then
" moved back to the original line, the cursor wasn't restored to its original
" position.
"
"inoremap    <S-Up>              <C-O>gk<C-O>vgjo<C-G>

" This works well, except when the selection starts at the very end of a
" physical line. When that happens, the previous character is also
" selected. I'm noting it here, at least for now, because it's simple and
" clean.
"
"inoremap    <S-Down>            <C-O>vgj<C-G>


" This is a technique I was experimenting with when trying to solve some
" of them problems listed above. This code is inactive and will probably
" be removed.
"
if 0
    function! CursWant()

        let wsv = winsaveview()

        return wsv['curswant']

    endfunction

    set statusline=%{CursWant()}

    inoremap    <expr> <S-Up>       "<C-O>gk"
                                    \ . "<C-O>vgj"
                                    \ . CursWant() . "\|"
                                    \ . "o<C-G>"

    inoremap    <expr> <S-Down>     "<C-O>gj"
                                    \ . "<C-O>vgk"
                                    \ . CursWant() . "\|"
                                    \ . "o<C-G>"

endif

" Visual mode
"
" XXX: Should shifted keys switch from Visual mode to Select mode, or stay in
" Visual mode? For now, they stay in Visual mode.
"
xnoremap    <S-Up>              gk
xnoremap    <S-Down>            gj

" Select mode
"
" Shift+Up/Down in Select mode enter Visual mode for one command, move the
" cursor one display line in the proper direction, then re-enter Select mode.
"
snoremap    <S-Up>              <C-O>gk
snoremap    <S-Down>            <C-O>gj


"" Shift+Home/End, Shift+Command+Left/Right

" Normal mode
"
" Enter Select mode, switch to Visual mode for a single command, then move
" (and automatically return to Select mode once the move is complete).
"
" Note: Watch out for a possible Vim bug. When the Normal-mode maps are
" defined to enter Visual mode (instead of Select mode, as they do now), the
" cursor doesn't land in the right place. It stops a few characters from the
" beginning of the line, for example, or wraps around to the next line when
" attempting to go to the end. When the Normal-mode maps are built for Select
" mode (again, as they are now), it works fine. (This might make it difficult,
" if not impossible, to make these maps dynamically adjust to the value of
" `selectmode`, though I haven't tried it yet.)
"
nnoremap    <expr> <S-Home>     "gh<C-O>" . (&wrap ? "g0" : "0")
nnoremap    <expr> <S-End>      "gh<C-O>" . (&wrap ? "g$" : "$")
nmap        <S-D-Left>          <S-Home>
nmap        <S-D-Right>         <S-End>

" Insert mode
"
" You might think the Insert-mode mapping for Shift+Home would be easy: just
" pop into Normal mode with Control+O and issue the Normal-mode Shift+Home
" map:
"
"   imap <S-Home>  <C-O><S-Home>
"
" Nope, sorry -- changing to Normal mode moves the cursor immediately before
" the last character, which leaves the last character out of the selection.
" (Yes, this can be "fixed" by changing `selection` from `exclusive` to
" `inclusive`, or `virtualedit` to `all`, but both have annoying side
" effects.)
"
" Here's the crazy workaround: Start the selection at the beginning of the
" line, extend the selection to the cursor's original position, then
" switch the cursor back to the other end of the selection. It looks like
" this:
"
" imap <expr> <S-Home>      --  Define an Insert-mode expression map for
"                               Shift+Home
"   "<C-O>"                 --  Enter Normal mode for a single command
"   (&wrap ? "g0" : "0")    --  Go to the start of the (screen/physical) line
"   "<C-O>v"                --  Start characterwise Visual mode
"   virtcol('.') . "\|"     --  Move to the original display column
"   "o<C-G>"                --  Switch the cursor to the other end of the
"                               Visual selection, then change from Visual to
"                               Select mode
"
" This has NOT been extensively tested, certainly not against all the possible
" combinations of `wrap`, `virtualedit`, `selection`, etc., but it already
" works better than anything else I've tried.
"
inoremap    <expr> <S-Home>     "<C-O>" . (&wrap ? "g0" : "0")
                                \ . "<C-O>v"
                                \ . virtcol('.') . "\|"
                                \ . "o<C-G>"

" The remaining three shifted Insert-mode maps can piggyback on the
" Normal-mode maps.
"
imap        <S-End>             <C-O><S-End>
imap        <S-D-Left>          <S-Home>
imap        <S-D-Right>         <C-O><S-End>

" Visual mode
"
xnoremap    <expr> <S-Home>     &wrap ? "g0" : "0"
xnoremap    <expr> <S-End>      &wrap ? "g$" : "$"
xmap        <S-D-Left>          <S-Home>
xmap        <S-D-Right>         <S-End>

" Select mode
"
" Extend the selection to the start/end of the display line.
"
" Shift+Home/End in Select mode enter Visual mode for one command, move the
" cursor within the display line in the proper direction, then re-enter
" Select mode.
"
" Note: These require that the corresponding Visual mode maps all be single
" commands.
"
smap        <S-Home>            <C-O><S-Home>
smap        <S-End>             <C-O><S-End>
smap        <S-D-Left>          <C-O><S-D-Left>
smap        <S-D-Right>         <C-O><S-D-Right>


"" Shift+Command+Up/Down

" Normal mode
"
nnoremap    <S-D-Up>            gh<C-O>gg
nnoremap    <S-D-Down>          gh<C-O>G

" Insert mode
"
" Note: Can't use the `` mark, since it ends up one character off. Have to use
" the '' mark and then jump to the proper virtual column.
"
inoremap    <expr> <S-D-Up>     "<C-O>gg"
                                \ . "<C-O>v''"
                                \ . virtcol('.') . "\|"
                                \ . "o<C-G>"

inoremap    <expr> <S-D-Down>   "<C-O>G"
                                \ . "<C-O>v''"
                                \ . virtcol('.') . "\|"
                                \ . "o<C-G>"

" Visual mode
"
xnoremap    <S-D-Up>            gg
xnoremap    <S-D-Down>          G

" Select mode
"
smap        <S-D-Up>            <C-O><S-D-Up>
smap        <S-D-Down>          <C-O><S-D-Down>


" Restore the previous Vim compatibility options.
"
let &cpo = s:save_cpo

" end selective.vim
