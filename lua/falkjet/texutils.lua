-- [nfnl] Compiled from fnl/falkjet/texutils.fnl by https://github.com/Olical/nfnl, do not edit.
local function in_mathzone()
  return (vim.fn["vimtex#syntax#in_mathzone"]() == 1)
end
local function in_text()
  return not __fnl_global__tex_2dutils.in_mathzone()
end
local function in_comment()
  return (vim.fn["vimtex#syntax#in_comment"]() == 1)
end
local function in_env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return ((is_inside[1] > 0) and (is_inside[2] > 0))
end
local function in_equation()
  return in_env("equation")
end
local function in_itemize()
  return in_env("itemize")
end
local function in_tikz()
  return in_env("tikzpicture")
end
return {["in-mathzone"] = in_mathzone, in_mathzone = in_mathzone, ["in-text"] = in_text, in_text = in_text, ["in-comment"] = in_comment, in_comment = __fnl_global__in_2dcommet, ["in-env"] = in_env, in_env = in_env, ["in-equation"] = in_equation, in_equation = in_equation, ["in-itemize"] = in_itemize, in_itemize = in_itemize, ["in-tikz"] = in_tikz, in_tikz = in_tikz}
