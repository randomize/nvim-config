
colorscheme Monokai_next

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

if g:os == "Darwin"
    nmap µ <A-m>
    nmap ∫ <A-b>
    map \ <leader>
endif

set virtualedit=block

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
