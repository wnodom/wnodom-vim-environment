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
" - Now that this is a plugin, it no longer bothers to set the MacVim
"   HIG-related options, since plugins are loaded too late for it to make a
"   difference. However, it doesn't really matter, since the plugin defines
"   most every keystroke that's affected by these options anyway.
"
"   (See MacVim.app/Contents/Resources/vim/gvimrc for more details.)
"
"
" TODO (or To-Consider):
"
" - Expand installation and usage docs.
"
" - Handle remaining bugs, noted in comments below.
"
" - In the MacVim gvimrc, Bjorn Winckler (maintainer of MacVim) says:
"
"     This is a work in progress.  If you feel so inclined, please help me
"     improve this file.
"
" - Control+Option+movement should work analogous to Control+Shift+movement.
"
" - Consider Shift+Option maps. Not sure what they'd do, but they're sort of
"   available.
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
" - Review all the Option maps for the missing-last-character bug.
"
" - Consider making these maps adjust to the `selectmode` setting, so all the
"   fancy keystroke maps work for both Visual and Select modes (depending on
"   which one the user prefers).
"
" - Improve documentation.
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



"""
""" Settings
"""

" Set selectmode, selection, and keymodel appropriately, as some of these
" mappings depend on it.
"
" Note: These options are also set by the :behave command, and within the
" MacVim internal gvimrc depending on the values of the HIG flag variables. If
" the keys don't do what you think they should, make sure you're not setting
" these values to unexpected values elsewhere in your configuration.
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
" Arrow keys leave Select mode and move up/down one display
" line, just like Visual mode.
"
snoremap    <Up>                <Esc>gk
snoremap    <Down>              <Esc>gj


"" Home/End, Command+Left/Right

" Normal mode
"
" Move to the start or end of the display/physical line, depending on the
" `wrap` setting.
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
imap        <D-Left>            <C-O><D-Left>
imap        <D-Right>           <C-O><D-Right>

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
" Note that this uses a technique similar to the Insert-mode Shift+Home
" mapping to avoid the missing-last-character bug.
"
" BUG: This still doesn't quite work as I'd like. Extra characters sometimes
" get selected when they shouldn't, especially when dealing with uneven line
" lengths.
"
inoremap    <S-Up>              <C-O>gk<C-O>vgjo<C-G>
inoremap    <S-Down>            <C-O>gj<C-O>vgko<C-G>

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
" XXX: These require that the corresponding Visual mode maps all be single
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
" XXX: This has the missing-last-character bug, but I'm guessing it can
" be fixed the same as with Insert-mode Shift+Home.
"
" Note: Can't use the `` mark, since it ends up one character off. Have to use
" the '' mark and then jump to the proper virtual column.
"
inoremap    <expr> <S-D-Up>     "<C-O>gg" . "<C-O>v''" . virtcol('.') . "\|" . "o<C-G>"
inoremap    <expr> <S-D-Down>   "<C-O>G"  . "<C-O>v''" . virtcol('.') . "\|" . "o<C-G>"

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
