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


" Enable true color
set termguicolors

" }}}


" {{{ 2.0 - Plugins =========================================================

call plug#begin('~/.config/nvim/plugged')

" NOTE: Make sure you use single quotes

" {{{ Colors
Plug 'tomasr/molokai'
"Plug 'nanotech/jellybeans.vim'
"Plug 'rafi/awesome-vim-colorschemes'
" }}}

Plug 'terryma/vim-expand-region'
"Plug 'Floobits/floobits-neovim'
Plug 'dzhou121/gonvim-fuzzy'
Plug 'RRethy/vim-illuminate'

"Plug 'critiqjo/lldb.nvim'

" Buffers manager
Plug 'vim-scripts/Buffergator'
Plug 'vim-scripts/BufOnly.vim'
Plug 'randomize/switch.vim'
Plug 'thinca/vim-quickrun'
Plug 'simeji/winresizer'

" Code alignment tool
Plug 'godlygeek/tabular'

" Super increment
Plug 'vim-scripts/VisIncr'

" Git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'gregsexton/gitv'

" Other musthave
Plug 'mileszs/ack.vim'
Plug 'eugen0329/vim-esearch'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'zandrmartin/vim-textobj-blanklines', {'branch': 'main'}
Plug 'kana/vim-textobj-fold'
Plug 'glts/vim-textobj-indblock'
Plug 'kana/vim-textobj-indent'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/restore_view.vim'
Plug 'tommcdo/vim-exchange'
Plug 'airblade/vim-rooter'

" Tools
Plug 'vim-scripts/open-browser.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'jmcantrell/vim-virtualenv'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax things
Plug 'vim-scripts/glsl.vim', { 'for': 'glsl' }
Plug 'BullyEntertainment/cg.vim', { 'for': 'cg' }
Plug 'sheerun/vim-polyglot'
Plug 'elzr/vim-json', { 'for': 'json'}
Plug 'tridactyl/vim-tridactyl', { 'for': 'tridactyl' }

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'reconquest/vim-pythonx'
"Plug 'szymonmaszke/vimpyter'
"Plug 'broesler/jupyter-vim'

Plug 'scrooloose/nerdtree'

" IDE features
"Plug 'xuhdev/SingleCompile'
Plug 'mbbill/undotree'
Plug 'lervag/vimtex'
Plug 'posva/vim-vue'
Plug 'ap/vim-css-color'
Plug 'leafgarland/typescript-vim'
Plug 'sukima/vim-tiddlywiki'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'puremourning/vimspector'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" fzf on Linux and OSX
if g:os == "Darwin"
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
elseif g:os == "Linux"
    Plug '/usr/share/vim/vimfiles/plugin/fzf.vim' | Plug 'junegunn/fzf.vim'
endif


" Tags
" Plug 'majutsushi/tagbar'
" Plug 'vim-scripts/taglist.vim'

" Session save/restore
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'

" Life coding
"Plug 'metakirby5/codi.vim'


" {{{ Language specific
" C++
" Formatting with clanfg format
Plug 'rhysd/vim-clang-format'

" C# support
Plug 'OrangeT/vim-csharp'

" Node js stuff
"Plug 'ternjs/tern_for_vim'
"Plug 'pangloss/vim-javascript'
"Plug 'moll/vim-node'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Ruby support
"Plug 'tpope/vim-rails', { 'for': 'ruby' }
"Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Go
"Plug 'fatih/vim-go', { 'for': 'go' }

" Java
"Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

" }}}

Plug 'tomtom/tcomment_vim'

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Web
Plug 'maksimr/vim-jsbeautify'

" Search Replace
Plug 'brooth/far.vim'
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

let g:mapleader = ","
let g:maplocalleader='\\'

" Custam mapping for file browser
nmap - :e %:h<cr>

autocmd FileType nerdtree call s:nerdtree_settings()
function! s:nerdtree_settings()
  nmap <buffer> - q
endfunction

" {{{ 3.0 - Key mappings ========================================================

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

" {{{ == Telescope =====

" nnoremap <leader>up :<C-u>DeniteProjectDir -start-filter file/rec/code <cr>
" nnoremap <leader>ua :<C-u>DeniteProjectDir -start-filter file/rec <cr>
" nnoremap <leader>uf :<C-u>Denite -start-filter file/rec <cr>
" nnoremap <leader>ue :<C-u>Denite -start-filter register <cr>
" nnoremap <leader>ug :<C-u>Denite -start-filter file/rec/git <cr>
" nnoremap <leader>ut :<C-u>Denite -start-filter file<cr>
" nnoremap <leader>ur :<C-u>Denite -start-filter file_mru<cr>
" nnoremap <leader>uo :<C-u>Denite -start-filter outline<cr>
" nnoremap <leader>uy :<C-u>Denite -start-filter history/yank<cr>
" nnoremap <leader>ub :<C-u>Denite -start-filter buffer<cr>
" nnoremap <leader>ul :<C-u>Denite -start-filter line<cr>
" nnoremap <leader>um :<C-u>Denite -start-filter bookmark<cr>
" nnoremap <leader>uc :<C-u>Denite -start-filter colorscheme<cr>
" nnoremap <leader>uh :<C-u>Denite -start-filter resume<cr>
" nnoremap <space>/ :Denite -start-filter grep:.<cr>

nnoremap <leader>uf <cmd>Telescope find_files<cr>
nnoremap <leader>ug <cmd>Telescope live_grep<cr>
nnoremap <leader>up <cmd>Telescope git_files<cr>
nnoremap <leader>ub <cmd>Telescope buffers<cr>
nnoremap <leader>uh <cmd>Telescope help_tags<cr>
nnoremap <leader>uc <cmd>Telescope command_history<cr>
nnoremap <leader>uq <cmd>Telescope quickfix<cr>
nnoremap <leader>um <cmd>Telescope marks<cr>
nnoremap <leader>uz <cmd>Telescope spell_suggest<cr>
nnoremap <leader>u/ <cmd>Telescope current_buffer_fuzzy_find<cr>

" }}}

" Tab in normal mode is useless - use it to %
nnoremap <Tab> %
vnoremap <Tab> %

" == Ack ===========
nnoremap <leader>a :Ack<space>

" == Fugitive =======
noremap <leader>gs :G<CR>
noremap <leader>gh :diffget //3<CR>
noremap <leader>gu :diffget //2<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gw :Gwrite<CR>
noremap <leader>gb :Gblame<CR>

vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)

" == Switch ========

nmap <silent> <space>t :Switch<CR>


" {{{ C# and Unity, TODO: detect Unity project too
autocmd FileType cs call s:csharp_unity_settings()
function! s:csharp_unity_settings()

  set foldmethod=syntax

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
"
" {{{ Presentation in vim, detect and set goyo (thanks to Nick Janetakis)

" Mappings to make Vim more friendly towards presenting slides.
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
  nnoremap <buffer> <Right> :n<CR>
  nnoremap <buffer> <Left> :N<CR>
  if !exists('#goyo')
    Goyo
  endif
endfunction

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
set textwidth=160
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

" Use rg
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

" }}} ===========================================================

" {{{ 5.0 - Appearence ================================================
silent! colorscheme molokai
" }}} ===========================================================

" {{{ 6.0 - Plugins Settings =========================================

"{{{ Coc - copypaste from official doc, tweaked

" if hidden is not set, TextEdit might fail.
"set hidden " Already set

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes // neovime probably has no issue with this

" lightlin no show
"set noshowmode
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <space>g <Plug>(coc-definition)
nmap <silent> <space>gd <Plug>(coc-type-definition)
nmap <silent> <space>gi <Plug>(coc-implementation)
nmap <silent> <space>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>ba  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>be  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>bc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>bo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>bs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>bj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>bk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>bp  :<C-u>CocListResume<CR>

" }}}

" LightLine {{{
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }

" }}}

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

" {{{ Git gutter
let g:gitgutter_diff_args = '-w'
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

" {{{ Airline
"let g:airline_theme = 'tomorrow'
"let g:airline_detected_modified = 1
"let g:airline_powerline_fonts = 1
"let g:airline_detect_iminsert = 0
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#hunks#non_zero_only = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#whitespace#enabled = 1
"let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline#extensions#whitespace#show_message = 1
"let g:airline#extensions#whitespace#trailing_format = 's:[%s]'
"let g:airline#extensions#whitespace#mixed_indent_format = 'i:[%s]'
"let g:airline#extensions#tagbar#flags = 'f'
"let g:airline_mode_map = {
"      \ '__' : '-',
"      \ 'n'  : 'N',
"      \ 'i'  : 'I',
"      \ 'R'  : 'R',
"      \ 'v'  : 'V',
"      \ 'V'  : 'B'
"      \ }
" }}}

" {{{ Indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#31332B ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2E2F29 ctermbg=235
" }}}



" {{{ Rustfmt
" let g:rustfmt_options = ''
" }}}

" {{{ Ack
let g:ackprg = 'ag --nogroup --nocolor --column'
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

" {{{ ZFZ rg

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -g "*.cs" <args> ', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
  " \ echomsg 'rg --column --line-number --no-heading --color=always -g "*.cs" <args>'
" }}}
"
" {{{ Tiddly


" Explicitly set the username of the tiddler 'creator' and 'modifier'
" If not set, this defaults to `$USER` or `$LOGNAME` (in that order)
let g:tiddlywiki_author = 'Eugene'

" Specify the location of your tiddlers. The subdir "tiddlers" is appended
" automatically if required.
let g:tiddlywiki_dir = '~/Documents/randy-wiki'

" Set the date format to use for journal tiddlers, as in the format string of date(1).
" This does not have to be at 'day' granularity - you can also use
" months / weeks / hours / whatever makes sense to you.
" Defaults to '%F' (ISO date = yyyy-mm-dd)
" '%A, %F (Week %V)'
let g:tiddlywiki_journal_format = '%d %B %Y'

" Don't Disable the default mappings
" let g:tiddlywiki_no_mappings=0

" Automatically update tiddler metadata ('modified' timestamp, 'modifier'
" username) on write - little bug here - need to have this not exist instead of =0
"let g:tiddlywiki_autoupdate=0
"
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

" }}}

filetype plugin indent on
syntax on

{{{
" Load profile specific
colorscheme Molokai_Eugene

iabbrev memail <mihailencoe@gmail.com>
iabbrev mename Eugene Mihailenco
iabbrev mefname Eugene
iabbrev melname Mihailenco
iabbrev mesite http://randomize.github.io/

let g:snips_author = 'Eugene Mihailenco <mihailencoe@gmail.com>'

autocmd FileType cs,cg,c,cpp,rs autocmd BufWritePre <buffer> call TrimShitOutOfFile()

" Nice terminal colors
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'
}}}
