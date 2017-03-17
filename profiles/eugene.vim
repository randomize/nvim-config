function! Profile_Plugins()
    Plug 'tomtom/tcomment_vim'

    " Go
    Plug 'fatih/vim-go', { 'for': 'go' }

    " Web
    Plug 'maksimr/vim-jsbeautify'

    " Search Replace
    Plug 'brooth/far.vim'
endfunction

function! Profile_Prelude()
    let g:mapleader = ","
    let g:maplocalleader='\\'

    " Custam mapping for file browser
    nmap - :e %:h<cr>

    autocmd FileType nerdtree call s:nerdtree_settings()
    function! s:nerdtree_settings()
      nmap <buffer> - q
    endfunction

endfunction

function! Profile_Settings()

    colorscheme Molokai_Eugene

    iabbrev memail <mihailencoe@gmail.com>
    iabbrev mename Eugene Mihailenco
    iabbrev mefname Eugene
    iabbrev melname Mihailenco
    iabbrev mesite http://randomize.github.io/

    let g:snips_author = 'Eugene Mihailenco <mihailencoe@gmail.com>'
endfunction
