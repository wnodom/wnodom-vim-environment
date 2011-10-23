" map_option_highlighting_keys.vim
"
" A temporary home for the Option+movement keys, while I turn the
" Shift+movement key script into a plugin.
"

"""
""" Option movement keys
"""
""" XXX: All the Option maps need to be reviewed for the
""" missing-last-character bug.
"""


"" Option+Left/Right

" Normal mode
"
nnoremap    <M-Left>            vh
nnoremap    <M-Right>           vl

" Insert mode
"
inoremap    <M-Left>            <C-O>vh
inoremap    <M-Right>           <C-O>vl

" Visual mode
"
xnoremap    <M-Left>            h
xnoremap    <M-Right>           l

" Select mode
"
snoremap    <M-Left>            <C-O>h
snoremap    <M-Right>           <C-O>l


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
xnoremap    <M-Up>              gk
xnoremap    <M-Down>            gj

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

" This is essentially the same map as Insert-mode Shift+Home; it just leaves
" off the Control+G at the end, so we stay in Visual mode instead of returning
" to Select mode. See the notes above imap Shift+Home for an explanation of
" how it works.
"
" XXX: Factor out common code between this map and imap Shift+Home.
" 
inoremap    <expr> <M-Home>     "<C-O>" . (&wrap ? "g0" : "0")
                                \ . "<C-O>v"
                                \ . virtcol('.') . "\|"
                                \ . "o"

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


" end map_option_highlighting_keys.vim

