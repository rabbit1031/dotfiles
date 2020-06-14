"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:config_dir    = expand($HOME . '/.config/nvim')
let s:dein_dir      = expand($HOME . '/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  
  call dein#load_toml(s:config_dir . '/plugins.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" --------------------
"  clipboard
" --------------------
set clipboard+=unnamedplus

" --------------------
"  appearance
" --------------------
colorscheme darcula
language en_US.UTF-8
set number
set showmatch
set cursorline

set splitright

" --------------------
"  encoding
" --------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

" --------------------
"  statusline
" --------------------
set showcmd
set cmdheight=2
set laststatus=2

" --------------------
"  indent
" --------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set expandtab

" --------------------
"  search
" --------------------
set incsearch
set ignorecase
set smartcase
set wrapscan

" --------------------
"  keymap
" --------------------

" tab
nnoremap <silent> tn :tabnew<CR>
nnoremap <silent> th :tabprevious<CR>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> tk :tabfirst<CR>
nnoremap <silent> tj :tablast<CR>
nnoremap <silent> tH :-tabmove<CR>
nnoremap <silent> tL :+tabmove<CR>

" buffer
nnoremap <silent> bh :bprevious<CR>
nnoremap <silent> bl :bnext<CR>

