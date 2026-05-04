function trim(s)
   return s:match("^%s*(.-)%s*$")
end

--- TODO: use luv, precomute and update using autocmd
function name()
	return trim(vim.fn.system{'git', 'config', 'user.name'})
end

function email()
	return trim(vim.fn.system{'git', 'config', 'user.email'})
end

return {
	s('hpack', fmt([[
		name: {pkgname}
		version: 0.1.0.0
		author:
		  - {name} <{email}>

		ghc-options: -Wall

		dependencies:
		  - base                 ^>=4.18.3.0
		  - parsec               ^>=3.1.18.0
		  - text                 ^>=2.1.4
		  - directory            ^>=1.3.10.1
		  - containers           ^>=0.8
		  - unordered-containers ^>=0.2.21

		library:
		  source-dirs: lib

		executable:
		  main: Main.hs 
		  source-dirs: app
		  dependencies:
			- {pkgname}

		tests:
		  spec:
			main: Spec.hs
			source-dirs: spec
			dependencies:
			  - hspec                ^>=2.11.17
			  - QuickCheck           ^>=2.18.0.0
			  - {pkgname}
	]], {
			pkgname = f(function() return vim.fn.expand('%:p:h:t') end),
			name = f(name),
			email = f(email),
		}))
}
