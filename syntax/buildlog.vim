" Vim syntax file
" Language:	Build tools log
" Maintainer:	Mihailenco Eugene <mihailencoe@gmail.com>
" Last Change:	Fri Apr  7 16:02:13 EEST 2017

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn keyword	buildlogerror	contained error halt fatal crash
syn keyword	buildlogwarning	contained warning issue caution missing
syn keyword	buildloginfo	contained compleated

" syn match       randypackComment      "\/\/.*" contains=randypackTodo,@Spell
" syn match       randypackHeader	      ".*\:$"
" syn match       randypackLocalPack    "^.*\-git "
" syn match       randypackLocalPack    "^.*\-svn "
" syn match       randypackLocalPack    "^\s*aur\/\S* "
" syn match       randypackLocalPack    "^\s*local\/\S* "
syn match       builderloginfo    "^.* : (I) "
syn match       builderlogerror    "^.* : (E) "
syn match       builderlogwarning    "^.* : (W) "
syn match       builderhaltmsg    "<<<<<<<<<<< HALT >>>>>>>>>>>>"
syn match       buildertag    "\[[^\]]\{-1,}\]"


hi builderloginfo guifg=#00ee00
hi builderlogwarning guifg=#eeee00
hi builderlogerror guifg=#ff0000

hi buildloginfo guifg=#00ee00
hi buildlogwarning guifg=#eeee00
hi buildlogerror guifg=#ff0000
hi buildertag guifg=#ff00ee
hi builderhaltmsg guifg=#ff0000

let b:current_syntax = "buildlog"

" vim: ts=8 sw=2
