" vimrc-essential.vim

set nocompatible        " Vim (not vi) settings. Set early for side effects.

set autoindent          " Copy indent from current line for new line.
set nosmartindent       " 'smartindent' breaks right-shifting of # lines.

set hidden              " Keep changed buffers without requiring saves.

set history=1000        " Remember this many command lines.

set ruler               " Always show the cursor position.
set showcmd             " Display incomplete commands.
set incsearch           " Do incremental searching.
set hlsearch            " Highlight latest search pattern.
set number              " Display line numbers.

set visualbell t_vb=    " Use null visual bell (no beeps or flashes).

set virtualedit=block   " Allow virtual editing when in Visual Block mode.

set textwidth=0         " Don't auto-wrap lines except for specific filetypes.

set mouse=a             " Enable mouse support if it's available.

set expandtab           " Insert spaces for <Tab> press; use spaces to indent.
set smarttab            " Tab respects 'shiftwidth', 'tabstop', 'softtabstop'.
set tabstop=2           " Set the visible width of tabs.
set softtabstop=2       " Edit as if tabs are 2 characters wide.
set shiftwidth=2        " Number of spaces to use for indent and unindent.
set shiftround          " Round indent to a multiple of 'shiftwidth'.

set background=dark     " Try to use colors suitable for a dark background.

set whichwrap+=<,>,[,]          " Left/right arrows can move across lines.
set backspace=indent,eol,start  " Backspace over everything in Insert mode.

set wildmode=longest,list       " Complete to longest string, list matches.

" Remove the current directory from the backup directory list.
" Save backup files in the current user's ~/tmp directory, or in the
" system /tmp directory if that's not possible.
"
set backupdir-=.
set backupdir^=~/tmp,/tmp

" Enable filetype detection and syntax highlighting, so language-dependent
" plugins, indentation files, syntax highlighting, etc., are loaded for
" specific filetypes.
"
filetype plugin indent on
syntax on

" end vimrc-essential.vim
