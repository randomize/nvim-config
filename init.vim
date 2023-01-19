"
" vim: set fdm=marker foldenable foldlevel=1 nospell:
"


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

" {{{ 2.0 - Plugins

call plug#begin('~/.config/nvim/plugged')

" NOTE: Make sure you use single quotes

" {{{ Colors
"Plug 'morhetz/gruvbox'
"Plug 'nanotech/jellybeans.vim'
"Plug 'rafi/awesome-vim-colorschemes'
"Plug 'EdenEast/nightfox.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'jacoborus/tender.vim'
" }}}

Plug 'terryma/vim-expand-region'
Plug 'dzhou121/gonvim-fuzzy'
Plug 'RRethy/vim-illuminate'
Plug 'chrisbra/unicode.vim'

"Plug 'critiqjo/lldb.nvim'

" {{{ Buffers stuff

" Buffer manager: <leader>b and <m-b>/<m-B> to move around, see help for more - alive+
Plug 'vim-scripts/Buffergator'

" Toggle true/false +=/-= and stuff - use <space>t - alive:- 
Plug 'randomize/switch.vim'

" Runs buffer contents as command - maps to <leader>r - alive:+++
Plug 'thinca/vim-quickrun'

" Enter resize mode with <c-e> - alive:+
Plug 'simeji/winresizer'

" <c-w>m toggle zoom mode like in tmux - alive:++
Plug 'dhruvasagar/vim-zoom'

" BufOnly command - alive:-
Plug 'vim-scripts/BufOnly.vim'

" Tabs and :BufferClose
Plug 'romgrk/barbar.nvim'

" }}}

" Code alignment tool
Plug 'godlygeek/tabular'

" Formatting tool
Plug 'sbdchd/neoformat'

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
Plug 'jmcantrell/vim-virtualenv'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Syntax things
Plug 'vim-scripts/glsl.vim', { 'for': 'glsl' }
Plug 'BullyEntertainment/cg.vim', { 'for': 'cg' }
Plug 'sheerun/vim-polyglot'
Plug 'elzr/vim-json', { 'for': 'json'}
Plug 'tridactyl/vim-tridactyl', { 'for': 'tridactyl' }
Plug 'beyondmarc/hlsl.vim', { 'for': 'hlsl' }
Plug 'meatballs/vim-xonsh'

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
Plug 'vimwiki/vimwiki'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'puremourning/vimspector'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tomtom/tcomment_vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'wsdjeg/vim-fetch' " To suport line/column specs like: file.cs:42:4

" Database stuff
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

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

Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}

" Tags
Plug 'preservim/tagbar'
" Plug 'vim-scripts/taglist.vim'

" Session save/restore
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'mhinz/vim-startify'

" Life coding
"Plug 'metakirby5/codi.vim'
Plug 'sillybun/vim-repl'
Plug 'inkarkat/vim-AdvancedSorters'


" {{{ Language specific
" C++
" Formatting with clanfg format
"Plug 'rhysd/vim-clang-format'

" C# support
Plug 'OrangeT/vim-csharp'

" Node js stuff
"Plug 'ternjs/tern_for_vim'
"Plug 'pangloss/vim-javascript'
"Plug 'moll/vim-node'
"Plug 'maksimr/vim-jsbeautify'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Ruby support
"Plug 'tpope/vim-rails', { 'for': 'ruby' }
"Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Java
"Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

" }}}

" Search Replace
Plug 'brooth/far.vim'

" Plug 'junegunn/vim-easy-align'

" Add plugins to &runtimepath
call plug#end()

" }}}

" {{{ 2.2 - Personal settings

let g:mapleader = '\'
let g:maplocalleader='_'

" }}}

" {{{ 3.0 - Leader Key mappings

" Map to close previews quickly
nmap <silent> <leader>p <c-w><c-z>

" Line wrap toggle
nmap <silent> <leader>w :set wrap!<CR>

" Session workflow
nmap <leader>so :OpenSession<space>
nmap <leader>ss :SaveSession<space>
nmap <leader>sd :DeleteSession<CR>
nmap <leader>sc :CloseSession<CR>

" Toggle things
" nmap <leader>1 :GundoToggle<CR>
nmap <leader>d :UndotreeToggle<CR>
" set pastetoggle=<leader>[
" nmap <leader>{ :TlistToggle<CR>
nmap <leader>o :TagbarToggle<CR>
nmap <leader>b :BuffergatorToggle<CR>

" cd-ing stuff
nmap <silent> <leader>cd :lcd %:h<CR>
nmap <silent> <leader>cdp :Rooter<CR>

" When search done : to remove highlight
nmap <silent> <leader>n :nohls<CR>

" Open config shortcut
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

" Urlencode/decode
vnoremap <leader>en :!python -c 'import sys,urllib.parse;print(urllib.parse.quote(sys.stdin.read().strip()))'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib.parse;print(urllib.parse.unquote(sys.stdin.read().strip()))'<cr>

" === Tabular ===

nmap <leader>tf :Tabularize / \w\+;/l0<CR>
nmap <leader>t= :Tabularize /=<cr>

" === Telescope ===

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
nnoremap <leader>us <cmd>Telescope grep_string<cr>
nnoremap <leader>ug <cmd>Telescope live_grep<cr>
nnoremap <leader>up <cmd>Telescope git_files<cr>
nnoremap <leader>ub <cmd>Telescope buffers<cr>
nnoremap <leader>uh <cmd>Telescope help_tags<cr>
nnoremap <leader>uc <cmd>Telescope command_history<cr>
nnoremap <leader>uq <cmd>Telescope quickfix<cr>
nnoremap <leader>um <cmd>Telescope marks<cr>
nnoremap <leader>uz <cmd>Telescope spell_suggest<cr>
nnoremap <leader>u/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>ur <cmd>Telescope oldfiles<cr>

nnoremap <c-enter> <cmd>Telescope buffers<cr>
" inoremap <c-enter> <cmd>Telescope buffers<cr>


" == Ack ===========
nnoremap <leader>a :Ack<space>

" == Fugitive =======
noremap <leader>gs :G<CR>
noremap <leader>gh :diffget //3<CR>
noremap <leader>gu :diffget //2<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gc :Git commit<CR>

" Remove trailing whitespaces
nmap <silent> <leader>rtw :call TrimShitOutOfFile()<CR>

" }}}

" {{{ Misc mappings
" When entering command, press %% to quickly insert current path
cmap %% <C-R>=expand('%:h').'/'<cr>

" Mapping <tab> to fast switch between buffers
nmap <silent> <tab> <c-^>

" Minus browser
nmap <silent> - :NERDTreeToggle %:h<cr>

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
" }}}

" {{{ Space mappings ==

nmap <silent> <space>t :Switch<CR>

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
nmap <space>su :OpenBrowserSearch -unity3d <c-r>=expand("<cword>")<cr><cr>
nmap <space>sr :OpenBrowserSearch -rust <c-r><c-w><cr>
nmap <space>sg :OpenBrowserSearch -duckduckgo

" Faster buffer operations
nmap <silent> <space> <NOP>
nmap <silent> <space>w  :w<CR>
nmap <silent> <space>q  :q<CR>
nmap <silent> <space>]  :bn<CR>
nmap <silent> <space>[  :bp<CR>
nmap <silent> <space>c  :bd<CR>
nmap <silent> <space>d  :bp\|bd #<CR>
nmap <silent> <space>(  :lne<CR>
nmap <silent> <space>)  :lp<CR>

nmap <silent> <c-j>  :bn<CR>
nmap <silent> <c-k>  :bp<CR>

" Copy paste to + register
nmap <silent> <space>y "+yy
nmap <silent> <space>p "+P
nmap <silent> <space>P "*P

" Barbar
nmap <space><space> :BufferPick<CR>

" }}}

" {{{ Autocmd mappings ====

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

" {{{ Presentation in vim, detect and set goyo (thanks to Nick Janetakis)

" Mappings to make Vim more friendly towards presenting slides.
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
  nnoremap <buffer> <Right> :n<CR>
  nnoremap <buffer> <Left> :N<CR>
  if !exists('#goyo')
    Goyo
  endif
endfunction
" }}}

" }}}

" {{{ 4.0 - Options

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
set listchars+=tab:\|\⋅

" Keep some spacing.
set sidescrolloff=1

" Show command
set showcmd

" Use rg
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

" Dont add newline
set nofixeol

" }}} ===========================================================

" {{{ 5.0 - Appearence
" silent! colorscheme molokai
"let g:gruvbox_italic=1
"autocmd vimenter * ++nested colorscheme gruvbox
colorscheme onehalfdark

" }}}

" {{{ 6.0 - Plugins Settings

" LightLine {{{
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
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
let g:UltiSnipsJumpBackwardTrigger = '<c-J>'
let g:UltiSnipsJumpForwardTrigger = '<c-K>'
let g:UltiSnipsSnippetDirectories = ['Ultisnips']
" }}} UltiSnips

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
let g:startify_bookmarks = ['~/.config/nvim/init.vim','~/.profile','~/nfo/commands.txt',]
let g:startify_change_to_dir = 0
let g:startify_files_number = 8
let g:startify_custom_indices = ['u', 'h', 'e', 't', 'o', 'n', 'a', 's', 'i', 'd', 'y', 'f', 'x']

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
"let g:buffergator_suppress_keymaps = 1
" }}}

" {{{ NERD Tree
let NERDTreeWinPos='right'
let NERDTreeIgnore = ['\.meta$']

autocmd FileType nerdtree call s:nerdtree_settings()
function! s:nerdtree_settings()
  nmap <buffer> - q
endfunction

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

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "javascript",
        "html",
        "css",
        "bash",
        "json",
        "go",
        "comment",
        "c_sharp",
        "cpp",
        "rust",
        "lua"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
EOF

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

" {{{ Telescope


" }}}

" Dadbod
let g:db_ui_use_nerd_fonts=1
" }}}

" {{{ 7.0 - Autos

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

autocmd FileType cs,cg,c,cpp,rs autocmd BufWritePre <buffer> call TrimShitOutOfFile()

" Gstatus to have nice cursor
autocmd BufEnter *.git/index setlocal cursorline

" }}}

" {{{ 8.0 Other stuff

iabbrev memail <emihailenco@protonmail.com>
iabbrev mename Eugene Mihailenco

let g:snips_author = 'Eugene Mihailenco <emihailenco@protonmail.com>'

" " }}}

filetype plugin indent on
syntax on

lua require 'lspsetup'

require'lspconfig'.pyright.setup{}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>ce', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>]d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>cq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>G', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>g', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>C', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>a', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><space>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- autocomplete config
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
  }
}

-- omnisharp lsp config
require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = on_attach,
  -- on_attach = function(_, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- end,
  cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(pid) },
}
EOF
