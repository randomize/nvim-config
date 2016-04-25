" Neovim rc here
" vim: set fdm=marker foldenable foldlevel=1 nospell:
"
" Eugene Mihailenco, 2016

" {{{ Platform specific switches
if has("unix")

  let s:uname = substitute(system('uname'), '\n', '', 'g')
  let g:python_host_prog='/usr/bin/python2'
  if s:uname == "Darwin"
    let g:python_host_prog='/usr/bin/python2.7'
  endif

endif

" Setup gloval dev variable
if !exists("g:bully_dev")
    let g:bully_dev = $bully_dev
endif

" 
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" }}}

" {{{ Plugins

call plug#begin('~/.config/nvim/plugged')

" NOTE: Make sure you use single quotes

Plug 'Buffergator'
Plug 'tomasr/molokai'
" Super increment
Plug 'VisIncr'

" Git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Syntastic replacer
Plug 'benekastah/neomake'

" Other musthave
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mileszs/ack.vim'

" TODO: why not bling/vim-airline ?
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" You complete me
Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --omnisharp-completer ' }
" Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --omnisharp-completer --racer-completer --tern-completer' }
" Plug 'Valloric/YouCompleteMe', {'do': 'python install.py --clang-completer --system-boost --system-libclang --omnisharp-completer --racer-completer --tern-completer' }

" C# support
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs', 'do': './omnisharp-roslyn/build.sh' }

" Syntax things
Plug 'vim-scripts/glsl.vim', { 'for': 'glsl' }
Plug 'BullyEntertainment/cg.vim', { 'for': 'cg' }

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ujihisa/unite-colorscheme'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'unite-yarm'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-ctrlp-autoignore'

" Tags for C++/C and others
Plug 'demelev/tagbar'

" Session save/restore
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

" Undo visual tree
Plug 'mbbill/undotree'


" Node js stuff
Plug 'ternjs/tern_for_vim'

" Plug 'junegunn/vim-easy-align'
" Add plugins to &runtimepath
call plug#end()

" }}}


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

" Folds
" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>

" CtrlP maps
" TODO: clear it
map <A-b> :CtrlPBuffer<cr>
map <A-m> :CtrlPBufTag<cr>
map <c-Tab> :tabn<cr>
nnoremap <leader>un vi}<<<esc>

" OmniSharp bindings TODO: compare with Eugene's - CS only!
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
nnoremap <leader><space> :OmniSharpFindMembersInBuffer<cr>

" cursor can be anywhere on the line containing an issue for this one
nnoremap <leader>x  :OmniSharpFixIssue<cr>
nnoremap <leader>fx :OmniSharpFixUsings<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>
nnoremap <leader>gd :OmniSharpGotoDefinition<cr>

" Session workflow
nmap <leader>so :OpenSession<space>
nmap <leader>ss :SaveSession<space>
nmap <leader>sd :DeleteSession<CR>
nmap <leader>sc :CloseSession<CR>


"TODO: clear there.
vmap <leader>wr :WrapWithRegion<cr>
vmap <leader>ifed :WrapWithIf "UNITY_EDITOR"<cr>
vmap <leader>ifedd :WrapWithIf 'UNITY_EDITOR \|\| DEVELOPMENT'<cr>


nmap <leader>wr :WrapWithRegion<cr>
nmap <leader>ifed :WrapWithIf "UNITY_EDITOR"<cr>

" Toggle things
" nmap <leader>1 :GundoToggle<CR>
nmap <leader>1 :UndotreeToggle<CR>
set pastetoggle=<leader>2
nmap <leader>3 :TlistToggle<CR>
nmap <leader>4 :TagbarToggle<CR>
nmap <leader>5 :NERDTreeToggle<CR>
nmap <leader>6 :BuffergatorToggle<CR>
"nmap <silent> <leader>6 :ConqueTermSplit bash<CR><Esc>:setlocal nolist<CR>a

" Make p in Visual mode replace the selected text with the \" register.
vmap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Indentation changes, but visual stays
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" move current line up/down one
nmap <c-j> ddp
nmap <c-k> ddkP

" move visual block up/down one
vmap <c-j> dp'[V']
vmap <c-k> dkP'[V']

" Duplications
" TODO: prevent register wipe
vmap <silent> <leader>= yP
nmap <silent> <leader>= YP

" move stuff to the right of cursor to next line
nmap <silent> <leader><CR> i<CR><ESC>k$

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" make directory
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" When search done : ,n to remove highlight
nmap <silent> <leader>n :nohls<CR>

" FSwitch mappings
nmap <silent> <leader>of :FSHere<CR>
nmap <silent> <leader>ol :FSRight<CR>
nmap <silent> <leader>oL :FSSplitRight<CR>
nmap <silent> <leader>oh :FSLeft<CR>
nmap <silent> <leader>oH :FSSplitLeft<CR>
nmap <silent> <leader>ok :FSAbove<CR>
nmap <silent> <leader>oK :FSSplitAbove<CR>
nmap <silent> <leader>oj :FSBelow<CR>
nmap <silent> <leader>oJ :FSSplitBelow<CR>

" Alright... let's try this out
imap jj <esc>

" Line wrap toggle
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Buffers

" == Space mappings ==

" Openbrowser maps
"nmap <leader>qu <Plug>(openbrowser-search)
nmap <space>sg :OpenBrowserSearch -google <c-r>=expand("<cword>")<cr><cr>
nmap <space>su :OpenBrowserSearch -unity3d <c-r>=expand("<cword>")<cr><cr>
nmap <space>ag :OpenBrowserSearch -google 
nmap <space>au :OpenBrowserSearch -unity3d 

" Faster command access
nmap <silent> <space> <NOP>
nmap <space>;  :
nmap <space><space>  :
nmap <silent> <space>w  :w<CR>
nmap <silent> <space>q  :q<CR>
nmap <silent> <space>]  :bn<CR>
nmap <silent> <space>[  :bp<CR>
nmap <silent> <space>c  :bd<CR>

" Remove trailing whitespaces
nmap <silent> <leader>rtw :%s/\s\+$//e<CR>:nohl<CR>
nmap <silent> <leader>rrt :%s/\t/    /g<CR>:nohl<CR>

" Copy paste to + register
nmap <silent> <space>y "+yy
vmap <silent> <space>y "+y
nmap <silent> <space>p "+p
nmap <silent> <space>pp "*p
nmap <silent> <space>P "+P
nmap <silent> <space>PP "*P


" Search the current file for the word under the cursor and display matches
nmap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Yank to end (like D and C)
nmap Y y$

" When entering command, press %% to quickly insert current path
cmap %% <C-R>=expand('%:h').'/'<cr>

" Mapping ,, to fast switch between buffers
nmap <silent> <leader><leader><space> <c-^>

" Tab in normal mode is useless - use it to %
nmap <Tab> %
vmap <Tab> %

" Ack on ,a
nmap <leader>a :Ack<space>

vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)

" Search
nnoremap gb :OpenURL <cfile><CR>
nnoremap gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>

" Folds
" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>


" === YCM =====
nmap <leader>yy :YcmForceCompileAndDiagnostics<cr>
nmap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<cr>
nmap <leader>yd :YcmCompleter GoToDefinition<cr>
nmap <leader>yc :YcmCompleter GoToDeclaration<cr>
nmap <leader>yt :YcmCompleter GetType<cr>


" == Unite =====
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <leader>uf :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async <cr>

nnoremap <leader>ut :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>ur :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>uy :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>ub :<C-u>Unite -buffer-name=buffer  buffer<cr>
nnoremap <leader>ul :<C-u>Unite -buffer-name=lines  line<cr>
nnoremap <leader>um :<C-u>Unite -buffer-name=bookmarks  bookmark<cr>
nnoremap <leader>uc :<C-u>Unite colorscheme<cr>
nnoremap <leader>uh :<C-u>Unite resume<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" Tab in normal mode is useless - use it to %
nmap <Tab> %
vmap <Tab> %

" Ack on ,a
nmap <leader>a :Ack<space>

if bully_dev != "demelev"
    " == Fugitive =======
    noremap <leader>gd :Gdiff<CR>
    noremap <leader>gc :Gcommit<CR>
    noremap <leader>gs :Gstatus<CR>
    noremap <leader>gw :Gwrite<CR>
    noremap <leader>gb :Gblame<CR>
endif

vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)
" }}}

" == Unite ===
nnoremap <leader>uf :call Unite_ctrlp()<cr>

" == Omnisharp ===
nnoremap <leader>sg :OmniSharpGotoDefinition<cr>
nnoremap <leader>si :OmniSharpFindImplementations<cr>
nnoremap <leader>st :OmniSharpFindType<cr>
nnoremap <leader>ss :OmniSharpFindSymbol<cr>
nnoremap <leader>su :OmniSharpFindUsages<cr>
nnoremap <leader>sm :OmniSharpFindMembers<cr>
nnoremap <leader>sx  :OmniSharpFixIssue<cr>
nnoremap <leader>sxu :OmniSharpFixUsings<cr>
nnoremap <leader>st :OmniSharpTypeLookup<cr>
nnoremap <leader>sd :OmniSharpDocumentation<cr>
nnoremap <leader>sk :OmniSharpNavigateUp<cr>
nnoremap <leader>sj :OmniSharpNavigateDown<cr>
nnoremap <leader>sl :OmniSharpReloadSolution<cr>
nnoremap <leader>sf :OmniSharpCodeFormat<cr>
nnoremap <leader>sa :OmniSharpAddToProject<cr>

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>sr :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>sh :OmniSharpHighlightTypes<cr>


" }}} ===========================================================

" {{{ Options ====================================================

set hlsearch     " Highlight search results
set ignorecase   " no sensitive to case
set incsearch    " enable incremental search
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
set listchars+=eol:¶
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=nbsp:⋅
set listchars+=tab:\|\ 

" Keep some spacing.
set sidescrolloff=1

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
let g:OmniSharp_host="http://localhost:20001"
let g:ycm_csharp_server_port = 20001
let g:OmniSharp_timeout = 1
let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_server_type = 'roslyn'
" }}} OmniSharp

" {{{ YouCompleteme
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
" let g:ycm_key_invoke_completion = '<c-Tab>'
let g:ycm_key_list_select_completion = ['<tab>', '<up>']
"let g:ycm_key_list_previous_completion = ['<s-tab>']
let g:ycm_extra_conf_globlist = ['~/rdev/cpp/*']
" }}} YouCompleteme

" {{{ Neomake
let g:neomake_error_sign = {
    \ 'text': '✖',
    \ 'texthl': 'ErrorMsg',
    \ }
let g:neomake_warning_sign = {
    \ 'text': '⚠',
    \ 'texthl': 'None',
    \ }
autocmd! BufWritePost * Neomake
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

" {{{ Unite
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10
let g:unite_candidate_icon="▷"
let g:unite_source_rec_async_command= ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:unite_source_history_yank_enable = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
\ 'ignore_pattern', join([
\ '.class$', '\.jar$',
\ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
\ '\.o$', '\.so$', '\.lo$', '\.lib$', '\.out$', '\.obj$', 
\ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$',
\ '\.ac$', '\.cache$', '\.0$', '\.meta$',
\ '\.anim$', '\.controller$'
\ ], '\|'))
" }}}

" {{{ Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

" {{{ CtrlP
let g:ctrlp_extensions = ['autoignore']
" }}}

" }}}

filetype plugin indent on
syntax on

