" Neovim rc here
" vim: set fdm=marker foldenable foldlevel=1 nospell:
"
" Eugene Mihailenco, 2016

" {{{ Platform specific switches
if has("unix")
  let s:uname = system("uname")
  let g:python_host_prog='/usr/bin/python'
  if s:uname == "Darwin\n"
    let g:python_host_prog='/usr/bin/python2.7'
  endif
endif

" }}}

" {{{ Plugins

call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
Plug 'tomasr/molokai'

" Git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Syntastic replacer
Plug 'benekastah/neomake'

" Other musthave
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'

" TODO: why not bling/vim-airline ?
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" You complete me
Plug 'Valloric/YouCompleteMe', {'do': 'python install.py --clang-completer --system-boost --system-libclang --omnisharp-completer --racer-completer' }

" C# support
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs', 'do': './omnisharp-roslyn/build.sh' }

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Add plugins to &runtimepath
call plug#end()

" }}}

" {{{ White spacing and Characters ===============================

set fillchars+=diff:⣿
set fillchars+=vert:│
set fillchars+=fold:-

" A visual cue for line-wrapping.
set showbreak=↪

" Visual cues when in 'list' model.
set nolist
set listchars+=eol:¶
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=nbsp:⋅
set listchars+=tab:\|\ 

" Keep some spacing.
set sidescrolloff=1

" }}} ===========================================================

" {{{ Behavior
let g:mapleader=','
let g:maplocalleader='\\'
" }}}

" {{{ Key mappings

" Faster command access
nmap <silent> <space> <NOP>
nmap <space>; :
nmap <space><space> :
nmap <silent><space>w :w<CR>
nmap <silent><space>q :q<CR>
nmap <silent><space>] :bn<CR>
nmap <silent><space>[ :bp<CR>
nmap <silent> <space>c :bd<CR>

" Quick jump out of insert mode
imap jj <esc>

" Line wrap toggle
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" F-mappings

nmap <silent> <f10> <esc>:set list!<cr>
imap <silent> <f10> <c-o>:set list!<cr>

" Folds
" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>

" }}} ===========================================================

" {{{ Options ====================================================

set infercase
set hlsearch
set incsearch

set number relativenumber
set nowrap
set textwidth=80
set ruler

" Tabs and indentation
set tabstop=4       " Tab size
set softtabstop=4   " Tab size in inset mode
set shiftwidth=4    " <<>> shifts size
set expandtab       " Tabs to spaces
set smarttab        " Consolidated editing
set smartindent     " When starting new line repeat indentation
set autoindent

" Other
set virtualedit=all


" }}} ===========================================================

" {{{ Appearence ================================================
colorscheme molokai
" }}} ===========================================================

" {{{ Abbrevs ===================================================
iabbrev memail <mihailencoe@gmail.com>
iabbrev mename Eugene Mihailenco
iabbrev mefname Eugene
iabbrev melname Mihailenco
iabbrev mesite http://randomize.github.io/
" }}} ===========================================================

" {{{ Plugins

" {{{ ultisnips
let g:snips_author = 'Eugene Mihailenco <mihailencoe@gmail.com>'
let g:UltiSnipsEnableSnipMate = 1
"let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-k>'
let g:UltiSnipsSnippetDirectories = ['Ultisnips']
" }}}

" Neomake
autocmd! BufWritePost * Neomake

" Airline

" {{{ vim-airline options
let g:airline_theme = 'tomorrow'
let g:airline_detected_modified = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#whitespace#trailing_format = 's:[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'i:[%s]'
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'v'  : 'V',
      \ 'V'  : 'B'
      \ }
" }}}


" }}}

filetype plugin indent on
syntax on

