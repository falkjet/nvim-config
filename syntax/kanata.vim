if exists("b:current_syntax")
	finish
endif

" Scheme syntax is mostly good enough
runtime! syntax/scheme.vim

syn clear schemeComment
syn clear schemeQuote
syn match kanataComment /;;.*$/ contains=schemeTodo,@Spell

hi def link kanataComment Comment

