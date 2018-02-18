set nocompatible

" --- backspace ---
set backspace=indent,eol,start

" --- appearance ---
syntax on
" colorscheme molokai
colorscheme darcula
set t_Co=256
set number
set showmatch
set cursorline
set colorcolumn=100

augroup AdditionalHighlights
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

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
set statusline+=%l/%L\ (%p%%)
set statusline+=\ %y[%{&fileformat}][%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]

" --- indent ---
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set expandtab

augroup fileTypeIndent
  autocmd!
  autocmd FileType php    setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" --- search ---
set incsearch
set ignorecase
set smartcase
set wrapscan
