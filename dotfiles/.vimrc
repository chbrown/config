set nocompatible
syntax on
"set number
set encoding=utf-8
set showcmd
filetype plugin indent on

" Whitespace stuff
set nowrap
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
"set autoindent
"set smartindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
"set laststatus=2

" Default color scheme
color zellner

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"nmap <leader>l :set list!<CR>
"set listchars=tab:▸\ ,eol:¬
set backspace=indent,eol,start

cmap w!! w !sudo tee % >/dev/null
