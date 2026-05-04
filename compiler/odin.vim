if exists("current_compiler")
  finish
endif
let current_compiler = "odin"

CompilerSet makeprg=odin
" matches error messages as below skipping final part after line number
" Error: ./file.dot: syntax error in line 1 near 'rankdir'
CompilerSet errorformat=
	\%f(%l:%c)\ %trror:\ %m,
	\%f(%l:%c)\ Syntax\ %trror:\ %m
