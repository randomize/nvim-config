" Neovim rc here
" vim: set fdm=marker foldenable foldlevel=1 nospell:
"
" Eugene Mihailenco, 2016

" {{{ 1.0 - OS Detector and global swithches

if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    elseif  has('win32unix')
        let g:os = "Cygwin"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
        " Darwin and Linux most common values for OSX and GNU/Linux
    endif
endif

" TODO rework
" if has("unix")
"
"   let s:uname = substitute(system('uname'), '\n', '', 'g')
"   let g:python_host_prog='/usr/bin/python2'
"   if s:uname == "Darwin"
"     let g:python_host_prog='/usr/bin/python2.7'
"   endif
"
" endif


" Enable true color
set termguicolors

" }}}

" {{{ 1.1 - Personal settings  ==================================================

" Setup gloval dev variable
if !exists("g:bully_dev")
    let g:bully_dev = $bully_dev
endif

let profile_filePath = fnamemodify(expand('<sfile>'), ':h').'/profiles/'.$bully_dev.'.vim'
if filereadable(profile_filePath)
    exec "source ".profile_filePath
endif

" }}}

" {{{ 2.0 - Plugins =========================================================

call plug#begin('~/.config/nvim/plugged')

" NOTE: Make sure you use single quotes

" {{{ Colors
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'rafi/awesome-vim-colorschemes'
" }}}

Plug 'terryma/vim-expand-region'

Plug 'critiqjo/lldb.nvim'

" Buffers manager
Plug 'Buffergator'
Plug 'randomize/switch.vim'
Plug 'thinca/vim-quickrun'

" Code alignment tool
Plug 'godlygeek/tabular'

" Super increment
Plug 'VisIncr'

" Git support
Plug 'airblade/vim-gitgutter'
Plug 'demelev/vim-fugitive', { 'branch' : 'feature/gs_diff' }
Plug 'gregsexton/gitv'

" Syntastic replacer
Plug 'benekastah/neomake'

" Other musthave
Plug 'mileszs/ack.vim'
Plug 'eugen0329/vim-esearch'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/restore_view.vim'
Plug 'tommcdo/vim-exchange'
Plug 'airblade/vim-rooter'

" Tools
Plug 'open-browser.vim'
" TODO: why not bling/vim-airline ?
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'


" Syntax things
Plug 'vim-scripts/glsl.vim', { 'for': 'glsl' }
Plug 'BullyEntertainment/cg.vim', { 'for': 'cg' }
Plug 'sheerun/vim-polyglot'
Plug 'elzr/vim-json', { 'for': 'json'}

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'reconquest/vim-pythonx'

Plug 'scrooloose/nerdtree'

" IDE features
Plug 'xuhdev/SingleCompile'
Plug 'mbbill/undotree'



" {{{ Denite
Plug 'Shougo/denite.nvim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
" }}}

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-ctrlp-autoignore'

Plug 'junegunn/fzf.vim'

" Tags
Plug 'demelev/tagbar'
Plug 'vim-scripts/taglist.vim'

" Session save/restore
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'

" Life coding
Plug 'metakirby5/codi.vim'


" {{{ Language specific
" C++
" Formatting with clanfg format
Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }

" C# support
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
Plug 'OrangeT/vim-csharp'

" Node js stuff
Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Ruby support
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Java
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

" }}}

call Profile_Plugins()
" Plug 'junegunn/vim-easy-align'
" Add plugins to &runtimepath
call plug#end()

" }}}

" {{{ 2.1 - Helper menus

" Encodings
menu Encoding.UTF-8          :e ++enc=utf-8
menu Encoding.Unicode        :e ++enc=unicode
menu Encoding.UCS-2          :e ++enc=ucs-2le<CR>
menu Encoding.UCS-4          :e ++enc=ucs-4
menu Encoding.KOI8-R         :e ++enc=koi8-r ++ff=unix <CR>
menu Encoding.KOI8-U         :e ++enc=koi8-u ++ff=unix <CR>
menu Encoding.CP1251         :e ++enc=cp1251
menu Encoding.IBM-855        :e ++enc=ibm855
menu Encoding.IBM-866        :e ++enc=ibm866 ++ff=dos <CR>
menu Encoding.ISO-8859-5     :e ++enc=iso-8859-5
menu Encoding.Latin-1        :e ++enc=latin1

" File formats
menu FileFormat.UNIX         :e ++ff=unix
menu FileFormat.DOS          :e ++ff=dos
menu FileFormat.Mac          :e ++ff=mac

" }}}

" Load profile settings
call Profile_Prelude()

" {{{ 3.0 - Key mappings ========================================================


" nmap <leader>t :terminal tmux attach<cr>

" Quick jump out of insert mode
imap jj <esc>

" Line wrap toggle
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" {{{ F-mappings

" F2 for quickfix
nmap <silent> <F2>  :call <SID>QuickfixToggle()<cr>
imap <silent> <F2>  <c-o>:call <SID>QuickfixToggle()<cr>

" Translator function
nmap <silent> <F3>  :call TRANSLATE()<cr>
imap <silent> <F3>  <c-o>:call TRANSLATE()<cr>

" Single compile binding
nmap <silent> <F5> <ESC>:SCCompile<CR>
nmap <silent> <F6> <ESC>:SCCompileRun<CR>

" Toggle spelling with the F7 key
nmap <silent> <F7> <ESC>:setlocal spell!<CR>
imap <silent> <F7> <c-o>:setlocal spell!<CR>

" Toggle keyboard layout
imap <silent> <F9> <C-^>

" Toggle unprintable <F10>
nmap <silent> <F10> <ESC>:set list!<CR>
imap <silent> <F10> <c-o>:set list!<CR>

nmap <silent>  <F11> :emenu Encoding.<Tab><Tab>
nmap <silent> <S-F11> :emenu FileFormat.<Tab><Tab>

nmap <silent> <F12> :NERDTreeToggle<CR>

" }}}

" CtrlP maps
" TODO: clear it
map <A-b> :CtrlPBuffer<cr>
map <A-m> :CtrlPBufTag<cr>
"map <c-Tab> :tabn<cr>

" Session workflow
nmap <leader>os :OpenSession<space>
nmap <leader>ss :SaveSession<space>
nmap <leader>ds :DeleteSession<CR>
nmap <leader>cs :CloseSession<CR>


" Toggle things
" nmap <leader>1 :GundoToggle<CR>
nmap <leader>1 :UndotreeToggle<CR>
set pastetoggle=<leader>2
nmap <leader>3 :TlistToggle<CR>
nmap <leader>4 :TagbarToggle<CR>
nmap <leader>5 :NERDTreeToggle<CR>
nmap <leader>b :BuffergatorToggle<CR>

" Make p in Visual mode replace the selected text with the \" register.
vmap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Indentation changes, but visual stays
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" move current line up/down one, can be repeated and accepts count as dist
" nmap <c-k> :normal ddkP<CR>
" nmap <c-j> :normal ddp<CR>

nnoremap <silent> <Plug>MoveLineDown :m+1<CR> :call repeat#set("\<Plug>MoveLineDown")<CR>
nmap <c-j> <Plug>MoveLineDown

nnoremap <silent> <Plug>MoveLineUp :m-2<CR> :call repeat#set("\<Plug>MoveLineUp")<CR>
nmap <c-k> <Plug>MoveLineUp

" move visual block up/down one
vmap <c-j> dp'[V']
vmap <c-k> dkP'[V']


" cd to the directory containing the file in the buffer, or 
" to root with cdp
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>cdp :Rooter<CR>

" make directory
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" When search done : ,n to remove highlight
nmap <silent> <leader>n :nohls<CR>

" Alright... let's try this out
imap jj <esc>

" Line wrap toggle
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Buffers

" {{{ Space mappings ==

" Better windows navigation
nmap <space>H <c-w>H
nmap <space>L <c-w>L
nmap <space>J <c-w>J
nmap <space>K <c-w>K
nmap <space>h <c-w>h
nmap <space>l <c-w>l
nmap <space>j <c-w>j
nmap <space>k <c-w>k

" Openbrowser maps
"nmap <leader>qu <Plug>(openbrowser-search)
nmap <space>sg :OpenBrowserSearch -google <c-r>=expand("<cword>")<cr><cr>
nmap <space>su :OpenBrowserSearch -unity3d <c-r>=expand("<cword>")<cr><cr>
nmap <space>sr :OpenBrowserSearch -rust <c-r><c-w><cr>
nmap <space>ag :OpenBrowserSearch -google 
nmap <space>au :OpenBrowserSearch -unity3d 
nmap <space>ar :OpenBrowserSearch -rust 
" Search
" nnoremap gb :OpenURL <cfile><CR>
" nnoremap gA :OpenURL http://www.answers.com/<cword><CR>
" nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
" nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>


" Faster command access
nmap <silent> <space> <NOP>
nmap <space>;  :
nmap <space><space>  :
nmap <silent> <space>w  :w<CR>
nmap <silent> <space>q  :q<CR>
nmap <silent> <space>]  :bn<CR>
nmap <silent> <space>[  :bp<CR>
nmap <silent> <space>c  :bd<CR>
nmap <silent> <space>d  :bp\|bd #<CR>
nmap <silent> <space>(  :lne<CR>
nmap <silent> <space>)  :lp<CR>

" Remove trailing whitespaces
nmap <silent> <leader>rtw :call TrimShitOutOfFile()<CR>
" nmap <silent> <leader>rtw :%s/\s\+$//e<CR>:nohl<CR>
" nmap <silent> <leader>rrt :%s/\t/    /g<CR>:nohl<CR> " use :retab

" Copy paste to + register
nmap <silent> <space>y "+yy
vmap <silent> <space>y "+y
nmap <silent> <space>p "+p
nmap <silent> <space>pp "*p
nmap <silent> <space>P "+P
nmap <silent> <space>PP "*P

" Duplications
vmap <silent> <space>= "dy"dP
nmap <silent> <space>= "dyy"dP
" }}}

" move stuff to the right of cursor to next line
nmap <silent> <leader><CR> i<CR><ESC>k$

" Search the current file for the word under the cursor and display matches
nmap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Edit shortcuts
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

" Yank to end (like D and C)
nnoremap Y y$

" When entering command, press %% to quickly insert current path
cmap %% <C-R>=expand('%:h').'/'<cr>

" Mapping ,, to fast switch between buffers
nmap <silent> <leader><leader><space> <c-^>

" Map to close previews quicly
nmap <silent> <leader>p <c-w><c-z>

" Vim expand region mappings.
vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)

" Folds
" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>


" === Tabular ===

nmap <leader>tf :Tabularize / \w\+;/l0<CR>
nmap <leader>t= :Tabularize /=<cr>

" {{{ == Unite =====
let g:unite_source_history_yank_enable = 1

nnoremap <leader>uf :<C-u>Denite -buffer-name=csfiles -mode=insert file_rec <cr>
nnoremap <leader>ug :<C-u>Denite -buffer-name=gitfiles -mode=insert file_rec/git <cr>
nnoremap <leader>up :<C-u>DeniteProjectDir -buffer-name=projectfiles -mode=insert file_rec/source <cr>
nnoremap <leader>ua :<C-u>DeniteProjectDir -buffer-name=projectfiles -mode=insert file_rec <cr>
nnoremap <leader>ut :<C-u>Denite -buffer-name=files file_rec <cr>
" nnoremap <leader>ut :<C-u>Denite -buffer-name=files   -mode-insert file<cr>
nnoremap <leader>ur :<C-u>Denite -buffer-name=mru     -mode=insert file_mru<cr>
nnoremap <leader>uo :<C-u>Denite -buffer-name=outline -mode=insert outline<cr>
" nnoremap <leader>uy :<C-u>Denite -buffer-name=yank    history/yank<cr>
nnoremap <leader>ub :<C-u>Denite -buffer-name=buffer  buffer<cr>
nnoremap <leader>ul :<C-u>Denite -buffer-name=lines  line<cr>
" nnoremap <leader>um :<C-u>Denite -buffer-name=bookmarks  bookmark<cr>
nnoremap <leader>uc :<C-u>Denite colorscheme<cr>
" nnoremap <leader>uh :<C-u>Denite resume<cr>
" nnoremap <space>/ :Denite grep:.<cr>


" }}}

" Tab in normal mode is useless - use it to %
nnoremap <Tab> %
vnoremap <Tab> %

" == Ack ===========
nnoremap <leader>a :Ack<space>

" == Fugitive =======
noremap <leader>gd :Gdiff<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gw :Gwrite<CR>
noremap <leader>gb :Gblame<CR>

vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)

" == Switch ========

nmap <silent> <space>t :Switch<CR>


" {{{ C# and Unity
autocmd FileType cs call s:omnisharp_settings()
function! s:omnisharp_settings()
  nnoremap <buffer> <space>g :OmniSharpGotoDefinition<cr>
  nnoremap <buffer> <leader>sg :OmniSharpGotoDefinition<cr>
  nnoremap <buffer> <leader>sx  :OmniSharpFixIssue<cr>
  nnoremap <buffer> <leader>sxu :OmniSharpFixUsings<cr>
  nnoremap <buffer> <leader>st :OmniSharpTypeLookup<cr>
  nnoremap <buffer> <leader>sd :OmniSharpDocumentation<cr>
  nnoremap <buffer> <leader>sk :OmniSharpNavigateUp<cr>
  nnoremap <buffer> <leader>sj :OmniSharpNavigateDown<cr>
  nnoremap <buffer> <leader>sl :OmniSharpReloadSolution<cr>
  nnoremap <buffer> <leader>sf :OmniSharpCodeFormat<cr>
  nnoremap <buffer> <leader>sa :OmniSharpAddToProject<cr>

  " Contextual code actions (requires CtrlP or unite.vim)
  nnoremap <buffer> <leader><space> :OmniSharpGetCodeActions<cr>
  " Run code actions with text selected in visual mode to extract method
  vnoremap <buffer> <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

  " rename with dialog
  nnoremap <buffer> <leader>sr :OmniSharpRename<cr>
  " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
  command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

  " Add syntax highlighting for types and interfaces
  nnoremap <buffer> <leader>sh :OmniSharpHighlightTypes<cr>

  " OmniSharp bindings from demelev
  nnoremap <buffer> <leader>fi :OmniSharpFindImplementations<cr>
  nnoremap <buffer> <leader>ft :OmniSharpFindType<cr>
  nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<cr>
  nnoremap <buffer> <leader>fu :OmniSharpFindUsages<cr>
  nnoremap <buffer> <leader>fm :OmniSharpFindMembers<cr>
  
  " Unindent (used for namespaces)
  nnoremap <leader>un vi}<<<esc>

  " Wrappers for Unity
  vmap <leader>wr :WrapWithRegion<cr>
  vmap <leader>ifed :WrapWithIf "UNITY_EDITOR"<cr>
  vmap <leader>ifedd :WrapWithIf 'UNITY_EDITOR \|\| DEVELOPMENT'<cr>
  nmap <leader>wr :WrapWithRegion<cr>
  nmap <leader>ifed :WrapWithIf "UNITY_EDITOR"<cr>

endfunction
" }}}

" }}} ===========================================================

" {{{ 4.0 - Options ====================================================

set hlsearch     " Highlight search results
set ignorecase   " no sensitive to case
set incsearch    " enable incremental search
set inccommand=split
set smartcase    " When meet uppercase -> sensitive
"set infercase

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

" Buffers ans splits
set hidden " allow hidden buffers
set splitbelow " new splits go down
set splitright " and right

" White spacing and Characters

set fillchars+=diff:⣿
set fillchars+=vert:│
set fillchars+=fold:-

" A visual cue for line-wrapping.
set showbreak=↪

" Visual cues when in 'list' model.
set nolist
"set listchars+=eol:¶
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=nbsp:⋅
set listchars+=tab:\|\ 

" Keep some spacing.
set sidescrolloff=1

" Show command
set showcmd

" }}} ===========================================================

" {{{ 5.0 - Appearence ================================================
colorscheme molokai
" }}} ===========================================================

" {{{ 6.0 - Plugins Settings =========================================

" {{{ Switch
let g:switch_mapping = ""
let g:switch_find_fallback_match_cursor_right = 1
let g:switch_find_fallback_match_line_start = 1

autocmd FileType cs let b:switch_custom_definitions =
    \ [
    \   [  '+=' , '-='  ],
    \   [  'private' , 'public', 'protected'  ],
    \   [  'struct' , 'class'  ],
    \   [  'OnDisable()' , 'OnEnable()' ],
    \   [  'Update()' , 'FixedUpdate()' ],
    \   [  'Debug.Log(' , 'Debug.LogError(' ]
    \ ]
" }}}


" {{{ Rooter
let g:rooter_patterns = ['build.gradle', '.git/']
let g:rooter_manual_only = 1

" }}}

" {{{ UltiSnips
let g:snips_author = 'Eugene Mihailenco <mihailencoe@gmail.com>'
let g:UltiSnipsEnableSnipMate = 1
"let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-k>'
let g:UltiSnipsSnippetDirectories = ['Ultisnips']
" }}} UltiSnips

" {{{ OmniSharp
let g:Omnisharp_start_server = 0
let g:Omnisharp_stop_server  = 0
" let g:OmniSharp_host="http://localhost:20001"
" let g:ycm_csharp_server_port = 20001
" let g:OmniSharp_timeout = 1
" let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_server_type = 'roslyn'
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}} OmniSharp

" {{{ Neomake
let g:neomake_error_sign = {
    \ 'text': '✖',
    \ 'texthl': 'ErrorMsg',
    \ }
let g:neomake_warning_sign = {
    \ 'text': '⚠',
    \ 'texthl': 'None',
    \ }

" autocmd! BufWritePost * Neomake
let g:neomake_cpp_enable_makers=['clang']
let g:neomake_cpp_enabled_makers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++14", "-Wextra", "-Wall", "-fsanitize=undefined","-g", "-lglfw", "-lgl", "-lvulkan"]
let g:neomake_enabled_makers=['make']
let g:neomake_make_maker = { 'exe': 'make'}
let g:neomake_verbose = 0

" }}} Neomake

" {{{ Airline
let g:airline_theme = 'tomorrow'
let g:airline_detected_modified = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
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

" {{{ Indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#31332B ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2E2F29 ctermbg=235
" }}}

" {{{ Denite

" if exists('g:loaded_denite') " for some reason this var is not alive here yet

call denite#custom#source(
    \ 'file_rec,file_rec/source,file_rec/git,file_mru,buffer,line,outline', 'matchers', ['matcher_regexp'])

" Define alias example (from Denite doc)
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
    \ ['git', '--work-tree=.', 'ls-files', '-co', '--exclude-standard'])

" Just fancy cursor for command line
call denite#custom#option('default', 'prompt', '▷')

" Do not sort file_mru sicne it is already sorted by time
call denite#custom#source(
            \ 'file_mru', 'sorters', [])

" Since pt and ag does better job searching sources, ignoring
" .git stuff and .gitignore things we configure file_rec to
" use them if any found on system
if executable('pt')
    call denite#custom#var('file_rec', 'command',
        \ ['pt', '--follow', '--nocolor', '--nogroup', '-g:', ''])
elseif executable('ag')
    call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    call denite#custom#alias('source', 'file_rec/source', 'file_rec')
    call denite#custom#var('file_rec/source', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', '.*\.cs$'])
endif

" KEY MAPPINGS
let insert_mode_mappings = [
	\  ['jj', '<denite:enter_mode:normal>', 'noremap'],
	\  ['<c-y>', '<denite:redraw>', 'noremap'],
	\ ]

let normal_mode_mappings = [
	\   ["'", '<denite:toggle_select_down>', 'noremap'],
	\   ['st', '<denite:do_action:tabopen>', 'noremap'],
	\   ['sg', '<denite:do_action:vsplit>', 'noremap'],
	\   ['sv', '<denite:do_action:split>', 'noremap'],
	\   ['sc', '<denite:quit>', 'noremap'],
	\   ['r', '<denite:redraw>', 'noremap'],
	\ ]

for m in insert_mode_mappings
	call denite#custom#map('insert', m[0], m[1], m[2])
endfor
for m in normal_mode_mappings
	call denite#custom#map('normal', m[0], m[1], m[2])
endfor

" endif

" }}}

" {{{ Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

" {{{ CtrlP
let g:ctrlp_extensions = ['autoignore']
" }}}

" {{{ Rust
function! On_rust_session()
    " Use cargo for neomake
    autocmd! BufWritePost * NeomakeProject cargo
endfunction
autocmd FileType rust call On_rust_session()
" }}}

" {{{ Startify
let g:startify_bookmarks = ['~/.vimrc','~/.zshrc','~/nfo/commands.txt',]
let g:startify_change_to_dir = 0
let g:startify_files_number = 8

if has('unix')
    let g:startify_custom_header =
                \ map(split(system('fortune | cowsay -W 60'), '\n') , '"   ". v:val') + ['','']
endif
" }}}

" {{{ Session
let g:startify_session_dir = "~/.config/nvim/session"
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"Function for autoloading project's settings and highlight
function! On_session_loaded()
    if exists("g:project_settings_loaded")
        return
    endif

    if filereadable('.vim/project_settings.vim')
        exec "source ".expand('~/.vim/SimpleIDE/idecs.vim')
        let g:project_settings_loaded = 1
    endif
endfunction
autocmd SessionLoadPost * call On_session_loaded()

" }}}

" {{{ Undo tree
let g:undotree_SplitWidth = 40
" }}}

" {{{ Buffergator
let g:buffergator_suppress_keymaps = 1
" }}}

" {{{ NERD Tree
let NERDTreeWinPos='right'
let NERDTreeIgnore = ['\.meta$']
" }}}

" {{{ Eighties settings
let g:eighties_bufname_additional_patterns = ['Tagbar']
" }}}

" {{{ OpenBrowser settings
let g:openbrowser_default_search = 'unity3d'
let g:openbrowser_search_engines = extend(
    \get(g:, 'openbrowser_search_engines', {}),
    \{
    \   'unity3d' : 'http://docs.unity3d.com/ScriptReference/30_search.html?q={query}',
    \   'rust' : 'https://doc.rust-lang.org/std/?search={query}'
    \})
" }}}

" {{{ Java completion
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" }}}

" }}}

" {{{ Autos ==================================================

" trim and go back to last place
" TODO: how to substitute internally without spoiling / 
" register
function TrimShitOutOfFile()
  let saved_cursor = getpos('.')
  try
    :%s/\s\+$//e
    :nohl
    :retab
  finally
    call setpos('.', saved_cursor)
  endtry
endfunction

" Gstatus to have nice cursor
autocmd BufEnter *.git/index setlocal cursorline

" Exclude quickfix and (not yet - TODO) scratch from bn/bp
" augroup qf
    " autocmd!
    " autocmd FileType qf set nobuflisted
" augroup END

" autocmd BufCreate [Scratch] set nobuflisted

" autocmd FileType cs,cg,c,cpp,rs autocmd BufWritePre <buffer> call TrimShitOutOfFile()

" }}}

filetype plugin indent on
syntax on

" Load profile specific
call Profile_Settings()
