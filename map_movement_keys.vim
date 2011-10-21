" map_movement_keys.vim
"
" Do all the weird stuff I have to do to make arrow/home/end/etc. keys (and
" their shifted variants) move by display lines instead of physical lines.
"
" Note: The 'standard' movement keys (h j k l ^ 0 $) are left as-is,
" so it's always possible to use them to do what they should do.
"
" TODO:
"
" - In the MacVim gvimrc, Bjorn Winckler (maintainer of MacVim) says:
"
"     This is a work in progress.  If you feel so inclined, please help me
"     improve this file.
"
" - Control+Option+movement should work analogous to Control+Shift+movement.
"
" - Change colors for Visual vs. Select mode.
"
" - Consider Shift+Option maps. Not sure what they'd do, but they're
"   sort of available.
"
" - Consider what PgUp/PgDn (with shift, control, etc.) should do.
"   (The shifted versions already work as expected.)
" 
" - Command-key maps are Mac-specific, and should probably be
"   set off as such.
" 
" - Home/End maps need to be tested on systems that, unlike my laptop,
"   actually have those keys.
"
" - Consider whether or not movement keys should exit Visual mode (like they
"   do for Select mode). They do now, but I don't know if I like it. It means
"   you can't use the arrow keys for Visual Block highlighting, for example.
"


" Set selectmode, selection, and keymodel appropriately, as some of these
" mappings depend on it.
"
" Note: These options are also set by the :behave command, and within the
" MacVim internal gvimrc depending on the values of flag variables (see
" below).
"
set selectmode=key,mouse
set selection=exclusive
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
nnoremap    <S-Down>            gh<C-O>gj
nnoremap    <S-Up>              gh<C-O>gk

" Alternative - enter Visual mode, move, then switch to Select mode:
"
"   nnoremap <S-Up>         vgk<C-G>
"   nnoremap <S-Down>       vgj<C-G>

" Insert mode
"
imap        <S-Up>              <C-O><S-Up>
imap        <S-Down>            <C-O><S-Down>

" Visual mode
"
" XXX: Should shifted keys switch from Visual mode to Select mode, or stay in
" Visual mode? For now, they stay in Visual mode.
"
xmap        <S-Up>              gk
xmap        <S-Down>            gj

" Select mode
"
" Shift+Up/Down in Select mode enter Visual mode for one command, move the
" cursor one display line in the proper direction, then re-enter Select mode.
"
snoremap    <S-Down>            <C-O>gj
snoremap    <S-Up>              <C-O>gk


"" Shift+Home/End, Shift+Command+Left/Right

" Normal mode
"
" Enter Select mode, switch to Visual mode for a single
" command, then move.
"
" XXX: BUG - This doesn't work properly when starting a selection from
" the last character on a line. The last character isn't selected. This
" can be fixed by changing the `selection` setting from `exclusive` to
" `inclusive`, but that has annoying side effects. I haven't come up
" with a great approach for solving this one yet.
"
nnoremap    <expr> <S-Home>     "gh<C-O>" . (&wrap ? "g0" : "0")
nnoremap    <expr> <S-End>      "gh<C-O>" . (&wrap ? "g$" : "$")
nmap        <S-D-Left>          <S-Home>
nmap        <S-D-Right>         <S-End>

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
" Note: Watch out for a possible bug. When the Normal-mode maps are defined to
" enter Visual mode (instead of Select mode, as they do now), the cursor
" doesn't land in the right place. It stops a few characters from the
" beginning of the line, for example, or wraps around to the next line when
" attempting to go to the end. When the Normal-mode maps are built for Select
" mode (again, as they are now), it works fine.
"
"
" Okay, so this is a little complicated. Here's what I'm doing to get around
" the missing last character when selecting from the end of the line in Insert
" mode:
"
" imap <expr> <S-Home>      --  Define an Insert-mode expression map for Shift+Home
"   "<C-O>"                 --  Enter Normal mode for a single command
"   (&wrap ? "g0" : "0")    --  Go to the start of the (screen/physical) line
"   "<C-O>v"                --  Start characterwise Visual mode
"   virtcol('.') . "\|"     --  Move to the display column where we started
"   "o<C-G>"                --  Switch the cursor to the other end of the
"                               Visual selection, then change from Visual to
"                               Select mode
"
" This has NOT been extensively tested, certainly not against all the possible
" combinations of 'wrap', 'virtualedit', 'selection', etc., but it already
" works better than anything else I've tried.
"
" XXX: Improve this documentation.
"
imap        <expr> <S-Home>     "<C-O>" . (&wrap ? "g0" : "0")
                                \ . "<C-O>v"
                                \ . virtcol('.') . "\|"
                                \ . "o<C-G>"

" Here's the simple version that doesn't work properly, since it just falls
" through to the Normal-mode map (which can't select the last character on the
" line under the usual 'selection' and 'virtualedit' settings).
"
" imap        <S-Home>            <C-O><S-Home>

imap        <S-End>             <C-O><S-End>
imap        <S-D-Left>          <S-Home>
imap        <S-D-Right>         <C-O><S-End>

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
imap        <S-D-Up>            <C-O><S-D-Up>
imap        <S-D-Down>          <C-O><S-D-Down>

" Visual mode
"
xnoremap    <S-D-Up>            gg
xnoremap    <S-D-Down>          G

" Select mode
"
smap        <S-D-Up>            <C-O><S-D-Up>
smap        <S-D-Down>          <C-O><S-D-Down>


"""
""" Option movement keys
"""

"" Option+Left/Right

" Normal mode
"
nnoremap    <M-Left>            vh
nnoremap    <M-Right>           vl

" Insert mode
"
imap        <M-Left>            <C-O>vh
imap        <M-Right>           <C-O>vl

" Visual mode
"
xnoremap    <M-Left>            h
xnoremap    <M-Right>           l

" Select mode
"
smap        <M-Left>            <C-O>h
smap        <M-Right>           <C-O>l


"" Option+Up/Down

" Make option up/down enter Visual mode, then move
" up/down by a display line.

" Normal mode
"
" Enter Visual mode then move.
"
nnoremap    <M-Down>            vgj
nnoremap    <M-Up>              vgk

" Insert mode
"
imap        <M-Up>              <C-O><M-Up>
imap        <M-Down>            <C-O><M-Down>

" Visual mode
"
" Just stay in Visual mode.
"
xmap        <M-Up>              gk
xmap        <M-Down>            gj

" Select mode
"
" Option+Up/Down in Select mode enter Visual mode for one command, move the
" cursor one display line in the proper direction, then re-enter Select mode.
"
" XXX: Stay in Select mode, or switch to Visual mode?
" 
snoremap    <M-Down>            <C-O>gj
snoremap    <M-Up>              <C-O>gk


"" Option+Home/End, Option+Command+Left/Right

" Normal mode
"
" Enter Visual mode then move.
"
nnoremap    <expr> <M-Home>     "v" . (&wrap ? "g0" : "0")
nnoremap    <expr> <M-End>      "v" . (&wrap ? "g$" : "$")
nmap        <M-D-Left>          <M-Home>
nmap        <M-D-Right>         <M-End>

" Insert mode
"
" Leave Insert mode for a single command, then trigger the Normal mode
" maps.
"
imap        <M-Home>            <C-O><M-Home>
imap        <M-End>             <C-O><M-End>
imap        <M-D-Left>          <C-O><M-Home>
imap        <M-D-Right>         <C-O><M-End>

" Visual mode
"
xnoremap    <expr> <M-Home>     &wrap ? "g0" : "0"
xnoremap    <expr> <M-End>      &wrap ? "g$" : "$"
xmap        <M-D-Left>          <M-Home>
xmap        <M-D-Right>         <M-End>

" Select mode
"
" Extend the selection to the start/end of the display line.
"
" Shift+Home/End in Select mode enter Visual mode for one command, move the
" cursor within the display line in the proper direction, then re-enter
" Select mode.
"
" XXX: These require that the corresponding Visual mode maps all be single
" commands. Might be better to not depend on the Normal mode maps.
"
smap        <M-Home>            <C-O><M-Home>
smap        <M-End>             <C-O><M-End>
smap        <M-D-Left>          <C-O><M-D-Left>
smap        <M-D-Right>         <C-O><M-D-Right>


"" Option+Up/Down

" Normal mode
"
nnoremap    <M-D-Up>            vgg
nnoremap    <M-D-Down>          vG

" Insert mode
"
imap        <M-D-Up>            <C-O><M-D-Up>
imap        <M-D-Down>          <C-O><M-D-Down>

" Visual mode
"
xnoremap    <M-D-Up>            gg
xnoremap    <M-D-Down>          G

" Select mode
"
smap        <M-D-Up>            <C-O><M-D-Up>
smap        <M-D-Down>          <C-O><M-D-Down>


" end map_movement_keys.vim
