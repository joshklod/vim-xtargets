" Name:    vim-xtargets
" Author:  Josh Klodnicki <joshklod@gmail.com>
" License: MIT License (See doc/xtargets-license.txt)
"
" See plugin/xtargets.vim

let s:cpo_save = &cpo
set cpo&vim

let s:var_defaults =
	\ [['set_compiler',  1],
	\  ['set_makeprg',   1],
	\  ['set_path',      1],
	\  ['force_makeprg', 0]]

for [s:name, s:value] in s:var_defaults
	let s:varname = 'g:xtargets#'.s:name
	if !exists(s:varname)
		let {s:varname} = s:value
	endif
endfor

unlet! s:var_defaults

" Check whether file exists in 'runtimepath'
function s:ExistsRTP(path)
	return !empty(globpath(&rtp, a:path))
endfunction

function xtargets#set_target(target)
	let l:exec_name = a:target.'-gcc'

	if g:xtargets#set_compiler
		if s:ExistsRTP('compiler/'.l:exec_name.'.vim')
			execute 'compiler' l:exec_name
		else
			compiler gcc
		endif
	endif

	if g:xtargets#set_makeprg && has("quickfix")
		if &makeprg =~# 'make'
			let l:makefile_names =
					\ ['GNUmakefile', 'makefile',
					\  'Makefile',    'Make*.mak']

			let l:using_make = 0
			for l:filename in l:makefile_names
				if !empty(glob(l:filename))
					echo 'Found' l:filename
					let l:using_make = 1
					break
				endif
			endfor
		else
			let l:using_make = 0
		endif

		if !l:using_make || g:xtargets#force_makeprg
			let &l:makeprg = l:exec_name.' %'
		endif
	endif

	if g:xtargets#set_path && has("file_in_path")
		" Current file and working directories first
		setlocal path =.,
		" Compiler headers
		if has("path_extra")
			let &l:path .=
					\  ',/usr/local/lib/gcc/'.a:target.'/**1/include-fixed'
					\ .',/usr/lib/gcc/'.a:target.'/**1/include-fixed'
					\ .',/usr/local/lib/gcc/'.a:target.'/**1/include'
					\ .',/usr/lib/gcc/'.a:target.'/**1/include'
		endif
		" Cross-target headers
		let &l:path .= ',/usr/local/'.a:target.'/include'
		           \ . ',/usr/'.a:target.'/include'
	endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
