return {
	s('ignore', fmta([[
		{-# OPTIONS_GHC -Wno-<> #-}
	]], { i(0) })),
	s('language', fmta([[
		{-# LANGUAGE <> #-}
	]], { i(0) })),
}
