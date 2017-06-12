set nocompatible

" --- appearance ---
syntax on
colorscheme molokai
set t_Co=256
set number
set showmatch
set cursorline

" --- encoding ---
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

" --- statusline ---
set showcmd
set cmdheight=2
set laststatus=2
set statusline=%F\ %m%r%h%w
set statusline+=%=
set statusline+=%l/%L(%p%%)\ [%{&fileformat}][%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]%y

" --- indent ---
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set expandtab

" --- search ---
set incsearch
set ignorecase
set smartcase
set wrapscan
