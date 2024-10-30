local function classname()
	return sn(nil, { i(1, vim.fn.expand("%:t:r")) })
end

return {
	s('sout', fmta('System.out.println(<>);', { i(0) })),
	s('souf', fmta('System.out.printf("<>\\n", <>);', { i(1), i(0) })),
	s('serr', fmta('System.err.println(<>);', { i(0), })),
	s('serf', fmta('System.err.printf("<>\\n", <>);', { i(1), i(0) })),
	s({ trig = 'maincls' }, fmta([[
		class <> {
		    public static void main(String[] args) {
		        <>
		    }
		}
	]], { d(1, classname), i(0) })),
	s({ trig = 'main' }, fmta([[
		public static void main(String[] args) {
		    <>
		}
	]], { i(0) })),
	s({ trig = 'cls' }, fmta([[
		class <> {
		    <>
		}
	]], { d(1, classname), i(0) })),
}
