-- [nfnl] fnl/config/plugins/autopair.fnl
local function single_quote_cond(fun)
  return (not fun.in_lisp() or fun.in_string())
end
local function backtick_cond(fun)
  return (not fun.in_lisp() or fun.in_string())
end
return {{"altermo/ultimate-autopair.nvim", event = {"InsertEnter", "CmdlineEnter"}, branch = "v0.6", opts = {internal_pairs = {{"[", "]", dosuround = true, fly = true, newline = true, space = true}, {"(", ")", dosuround = true, fly = true, newline = true, space = true}, {"{", "}", dosuround = true, fly = true, newline = true, space = true}, {"\"", "\"", suround = true, multiline = false}, {"'", "'", alpha = true, cond = single_quote_cond, nft = {"tex"}, suround = true, multiline = false}, {"`", "'", ft = {"m4"}}, {"`", "`", cond = backtick_cond, nft = {"tex", "m4"}, multiline = false}, {"``", "''", ft = {"tex"}}, {"```", "```", ft = {"markdown"}, newline = true}, {"<!--", "-->", ft = {"markdown", "html"}, space = true}, {"\"\"\"", "\"\"\"", ft = {"python"}, newline = true}, {"'''", "'''", ft = {"python"}, newline = true}}}}}
