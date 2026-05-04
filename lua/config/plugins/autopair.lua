-- [nfnl] fnl/config/plugins/autopair.fnl
local function in_lisp()
  return (vim.o.lisp or ("fennel" == vim.o.ft) or ("clojure" == vim.o.ft))
end
local function single_quote_cond(fun)
  return (not in_lisp() or fun.in_string())
end
local function backtick_cond(fun)
  return (not in_lisp() or fun.in_string())
end
local function _1_(fun)
  return not in_lisp()
end
local function _2_(fun)
  return not in_lisp()
end
local function _3_(fun)
  return not in_lisp()
end
local function _4_(fun)
  return in_lisp()
end
local function _5_(fun)
  return in_lisp()
end
local function _6_(fun)
  return in_lisp()
end
do local _ = {{"altermo/ultimate-autopair.nvim", event = {"InsertEnter", "CmdlineEnter"}, branch = "v0.6", opts = {internal_pairs = {{"[", "]", dosuround = true, fly = true, newline = true, space = true, cond = _1_}, {"(", ")", dosuround = true, fly = true, newline = true, space = true, cond = _2_}, {"{", "}", dosuround = true, fly = true, newline = true, space = true, cond = _3_}, {"[", "]", dosuround = true, fly = true, space = true, cond = _4_, newline = false}, {"(", ")", dosuround = true, fly = true, space = true, cond = _5_, newline = false}, {"{", "}", dosuround = true, fly = true, space = true, cond = _6_, newline = false}, {"\"", "\"", suround = true, multiline = false}, {"'", "'", alpha = true, cond = single_quote_cond, nft = {"tex"}, suround = true, multiline = false}, {"`", "'", ft = {"m4"}}, {"`", "`", cond = backtick_cond, nft = {"tex", "m4"}, multiline = false}, {"``", "''", ft = {"tex"}}, {"```", "```", ft = {"markdown"}, newline = true}, {"<!--", "-->", ft = {"markdown", "html"}, space = true}, {"\"\"\"", "\"\"\"", ft = {"python"}, newline = true}, {"'''", "'''", ft = {"python"}, newline = true}}}}} end
local function _7_()
  require("nvim-autopairs").get_rules("'")[1]["not_filetypes"] = {"scheme", "lisp"}
  return nil
end
return {{"windwp/nvim-autopairs", event = "InsertEnter", config = true, init = _7_}}
