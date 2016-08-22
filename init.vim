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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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
" }}}

" Buffers manager
Plug 'Buffergator'

" Code alignment tool
Plug 'godlygeek/tabular'

" Super increment
Plug 'VisIncr'

" Git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

" Syntastic replacer
Plug 'benekastah/neomake'

" Other musthave
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/restore_view.vim'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-exchange'

" Tools
Plug 'open-browser.vim'
" TODO: why not bling/vim-airline ?
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

"
" You complete me
Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --omnisharp-completer --racer-completer ' }
" Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --omnisharp-completer --racer-completer --tern-completer' }
" Plug 'Valloric/YouCompleteMe', {'do': 'python install.py --clang-completer --system-boost --system-libclang --omnisharp-completer --racer-completer --tern-completer' }

" Syntax things
Plug 'vim-scripts/glsl.vim', { 'for': 'glsl' }
Plug 'BullyEntertainment/cg.vim', { 'for': 'cg' }
Plug 'sheerun/vim-polyglot'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'scrooloose/nerdtree'

" IDE features
Plug 'xuhdev/SingleCompile'
Plug 'mbbill/undotree'

" {{{ Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ujihisa/unite-colorscheme'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'unite-yarm'
Plug 'Shougo/unite-outline'
Plug 'tsukkee/unite-tag'
" }}}

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-ctrlp-autoignore'

" Tags
Plug 'demelev/tagbar'
Plug 'vim-scripts/taglist.vim'

" Session save/restore
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'

" {{{ Language specific
" C++
" Formatting with clanfg format
Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }

" C# support
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs', 'do': './omnisharp-roslyn/build.sh' }

" Node js stuff
Plug 'ternjs/tern_for_vim'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Ruby support
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" }}}

call Profile_Plugins()
" Plug 'junegunn/vim-easy-align'
" Add plugins to &runtimepath
call plug#end()

" }}}

" Load profile settings
call Profile_Prelude()

" {{{ 3.0 - Key mappings ========================================================

" Faster command access
nmap <silent><space> <NOP>
nmap <space>; :
nmap <space><space> :
nmap <silent><space>w :w<CR>
nmap <silent><space>q :q<CR>
nmap <silent><space>] :bn<CR>
nmap <silent><space>[ :bp<CR>
nmap <silent><space>c :bd<CR>

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
nmap <leader>so :OpenSession<space>
nmap <leader>ss :SaveSession<space>
nmap <leader>sd :DeleteSession<CR>
nmap <leader>sc :CloseSession<CR>


" Toggle things
" nmap <leader>1 :GundoToggle<CR>
nmap <leader>1 :UndotreeToggle<CR>
set pastetoggle=<leader>2
nmap <leader>3 :TlistToggle<CR>
nmap <leader>4 :TagbarToggle<CR>
nmap <leader>5 :NERDTreeToggle<CR>
nmap <leader>6 :BuffergatorToggle<CR>

" Make p in Visual mode replace the selected text with the \" register.
vmap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Indentation changes, but visual stays
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" move current line up/down one, can be repeated and accepts count as dist
" nmap <c-k> :normal ddkP<CR>
" nmap <c-j> :normal ddp<CR>

nnoremap <silent> <Plug>MoveLineDown :normal m+1<CR> :call repeat#set("\<Plug>MoveLineDown")<CR>
nmap <c-j> <Plug>MoveLineDown

nnoremap <silent> <Plug>MoveLineUp :normal m-1<CR> :call repeat#set("\<Plug>MoveLineUp")<CR>
nmap <c-k> <Plug>MoveLineUp

" move visual block up/down one
vmap <c-j> dp'[V']
vmap <c-k> dkP'[V']


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

" {{{ Space mappings ==

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
nnoremap <silent> <leader>eg :vsplit ~/.gitconfig<cr>

" Yank to end (like D and C)
nnoremap Y y$

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

" Folds
" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>


" === YCM =====
nmap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<cr>
nmap <leader>yd :YcmCompleter GoToDefinition<cr>
nmap <leader>yc :YcmCompleter GoToDeclaration<cr>
nmap <leader>yt :YcmCompleter GetType<cr>


" {{{ == Unite =====
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <leader>uf :<C-u>Unite -buffer-name=files   -start-insert file_rec/async <cr>
nnoremap <leader>ug :<C-u>Unite -buffer-name=gitfiles   -start-insert file_rec/git <cr>
nnoremap <leader>ut :<C-u>Unite -buffer-name=files   -start-insert file<cr>
nnoremap <leader>ur :<C-u>Unite -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>uo :<C-u>Unite -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>uy :<C-u>Unite -buffer-name=yank    history/yank<cr>
nnoremap <leader>ub :<C-u>Unite -buffer-name=buffer  buffer<cr>
nnoremap <leader>ul :<C-u>Unite -buffer-name=lines  line<cr>
nnoremap <leader>ut :<C-u>Unite -buffer-name=tags  tag:%<cr>
nnoremap <leader>um :<C-u>Unite -buffer-name=bookmarks  bookmark<cr>
nnoremap <leader>uc :<C-u>Unite colorscheme<cr>
nnoremap <leader>uh :<C-u>Unite resume<cr>
nnoremap <space>/ :Unite grep:.<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
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

" {{{ C# and Unity
autocmd FileType cs call s:omnisharp_settings()
function! s:omnisharp_settings()
  nnoremap <buffer> <leader>sg :OmniSharpGotoDefinition<cr>
  nnoremap <buffer> <leader>si :OmniSharpFindImplementations<cr>
  nnoremap <buffer> <leader>st :OmniSharpFindType<cr>
  nnoremap <buffer> <leader>ss :OmniSharpFindSymbol<cr>
  nnoremap <buffer> <leader>su :OmniSharpFindUsages<cr>
  nnoremap <buffer> <leader>sm :OmniSharpFindMembers<cr>
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
  
  " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
  nnoremap <buffer> <leader>ss :OmniSharpStartServer<cr>
  nnoremap <buffer> <leader>sp :OmniSharpStopServer<cr>
  
  " Add syntax highlighting for types and interfaces
  nnoremap <buffer> <leader>sh :OmniSharpHighlightTypes<cr>

  " OmniSharp bindings from demelev
  nnoremap <buffer> <leader>fi :OmniSharpFindImplementations<cr>
  nnoremap <buffer> <leader>ft :OmniSharpFindType<cr>
  nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<cr>
  nnoremap <buffer> <leader>fu :OmniSharpFindUsages<cr>
  nnoremap <buffer> <leader>fm :OmniSharpFindMembersInBuffer<cr>
  " nnoremap <buffer> <leader><space> :OmniSharpFindMembersInBuffer<cr>
  
  " cursor can be anywhere on the line containing an issue for this one
  " nnoremap <buffer> <leader>x  :OmniSharpFixIssue<cr>
  " nnoremap <buffer> <leader>fx :OmniSharpFixUsings<cr>
  " nnoremap <buffer> <leader>tt :OmniSharpTypeLookup<cr>
  " nnoremap <buffer> <leader>dc :OmniSharpDocumentation<cr>
  " nnoremap <buffer> <leader>gd :OmniSharpGotoDefinition<cr>

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

" Show command
set showcmd

" }}} ===========================================================

" {{{ 5.0 - Appearence ================================================
colorscheme molokai
" }}} ===========================================================

" {{{ 6.0 - Plugins Settings =========================================

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
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}} OmniSharp

" {{{ YouCompleteme
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
" let g:ycm_key_invoke_completion = '<c-Tab>'
let g:ycm_key_list_select_completion = ['<tab>', '<up>']
"let g:ycm_key_list_previous_completion = ['<s-tab>']
let g:ycm_extra_conf_globlist = ['~/rdev/cpp/*']
let g:ycm_confirm_extra_conf = 0
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
let g:neomake_cpp_enable_markers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++14", "-Wextra", "-Wall", "-fsanitize=undefined","-g", "-lglfw", "-lgl"]

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
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''

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

" {{{ Rust
let g:ycm_rust_src_path = '/usr/src/rust/src'
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
let g:session_directory = "~/.vim/session"
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
"
" }}}

" {{{ Autos ==================================================

" Gstatus to have nice cursor
autocmd BufEnter *.git/index setlocal cursorline

" Exclude quickfix and (not yet - TODO) scratch from bn/bp
" augroup qf
    " autocmd!
    " autocmd FileType qf set nobuflisted
" augroup END

" autocmd BufCreate [Scratch] set nobuflisted

" }}}

filetype plugin indent on
syntax on

" Load profile specific
call Profile_Settings()
