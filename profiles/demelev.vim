function! Profile_Plugins()
    Plug 'scrooloose/nerdcommenter'
    Plug 'godlygeek/tabular'
    Plug 'demelev/TagHighlight', { 'for': 'cs'}
    Plug 'LucHermitte/SearchInRuntime' | Plug 'LucHermitte/lh-vim-lib'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'Raimondi/delimitMate'
    Plug 'junegunn/limelight.vim'
    Plug 'rafi/awesome-vim-colorschemes'

    " Search Replace
    Plug 'brooth/far.vim'

    " Go lang
    "Plug 'fatih/vim-go', { 'for': 'go' }
endfunction

function! Profile_Prelude()
endfunction

function! Profile_Settings()
    "colorscheme Monokai_next
    colorscheme gruvbox

    " vim -b : edit binary using xxd-format!
    augroup Binary
      au!
      au BufReadPre  *.bin let &bin=1
      au BufReadPost *.bin if &bin | %!xxd
      au BufReadPost *.bin set ft=xxd | endif
      au BufWritePre *.bin if &bin | %!xxd -r
      au BufWritePre *.bin endif
      au BufWritePost *.bin if &bin | %!xxd
      au BufWritePost *.bin set nomod | endif
    augroup END


" {{{ Mappings
    if g:os == "Darwin"
        nmap µ <A-m>
        nmap ∫ <A-b>
        map \ <leader>
    endif

    nmap - :e %:h<cr>

    nmap <space>h <c-w>h
    nmap <space>l <c-w>l
    nmap <space>j <c-w>j
    nmap <space>k <c-w>k

" }}}

    set virtualedit=block
    set list

    if g:os == "Linux" || g:os == "Darwin"
        let g:dev_temp='/tmp'
    elseif g:os == "Windows"
        if exists("$VIM_TMP")
           let g:dev_temp=$VIM_TMP
        else
           let g:dev_temp=$TMP
        endif
    endif

    exec ":set backupdir=".g:dev_temp

    set undofile
    exec ":set undodir=".g:dev_temp
    let g:ycm_rust_src_path = '~/.cargo/rustc-1.9.0/src/'
    let g:snips_author = 'Emeliov Dmitri <demelev1990@gmail.com>'

    "let g:esearch = {
      "\ 'adapter':    'ack',
      "\ 'backend':    'vimproc',
      "\ 'out':        'win',
      "\ 'batch_size': 1000,
      "\ 'use':        ['visual', 'hlsearch', 'last'],
      "\}

" {{{ Go lang settings ================
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_types = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    let g:go_list_type = "quickfix"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" }}}
endfunction
