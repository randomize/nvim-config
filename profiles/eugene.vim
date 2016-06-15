function! Profile_Plugins()
    Plug 'tomtom/tcomment_vim'
endfunction

function! Profile_Prelude()
    let g:mapleader = ","
    let g:maplocalleader='\\'
endfunction

function! Profile_Settings()

    iabbrev memail <mihailencoe@gmail.com>
    iabbrev mename Eugene Mihailenco
    iabbrev mefname Eugene
    iabbrev melname Mihailenco
    iabbrev mesite http://randomize.github.io/

    let g:snips_author = 'Eugene Mihailenco <mihailencoe@gmail.com>'
endfunction
