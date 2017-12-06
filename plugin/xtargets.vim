" Name:        vim-xtargets
" Description: Easy switching between GCC cross-compilation targets
" Author:      Josh Klodnicki <joshklod@gmail.com>
" Modified:    6 Dec 2017
" Version:     0.5
" License:     MIT License (See doc/xtargets-license.txt)
"
" TODO
" - Autocommands and target detection mechanism
" - More portable 'path'

if exists("g:loaded_xtargets")
	finish
endif
let g:loaded_xtargets = 1

if !has("user_commands")
	finish
endif

if !exists(":Target")
	command -bar -nargs=1 Target call xtargets#set_target(<q-args>)
endif
