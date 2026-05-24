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
nnoremap <silent> <C-b>h :bprevious<CR>
nnoremap <silent> <C-b>l :bnext<CR>

