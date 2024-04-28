local npairs     = require 'nvim-autopairs'
local Rule       = require 'nvim-autopairs.rule'
local cond       = require 'nvim-autopairs.conds'

local pluginopts = {
  disable_filetype = { "TelescopePrompt", "vim" },
}

npairs.setup(pluginopts)

local function in_mathzone()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- Disable [] in latex mathzone
npairs.remove_rule('[')
npairs.add_rule(
  Rule('[', ']')
  :with_pair(function(opts) return not in_mathzone() end)
  :with_move(function(opts) return opts.char == ']' end)
  :with_del(cond.done())
)

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        local b = {}
        for k, v in pairs(brackets) do
          b[k] = v[1] .. v[2]
        end
        return vim.tbl_contains(b, pair)
      end)
      :with_del(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col - 1) .. opts.line:sub(opts.col + 2, opts.col + 2)
        local b = {}
        for k, v in pairs(brackets) do
          b[k] = v[1] .. v[2]
        end
        return vim.tbl_contains(b, pair)
      end)
}

for _, bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%' .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2])
        :with_del(cond.none())
  }
end

npairs.add_rules {
  Rule("%", "%"):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return pair == "{}"
  end),
  Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 2, opts.col + 1)
        return pair == "{%%}"
      end)
      :with_del(function(opts)
        local left = opts.line:sub(opts.col - 2, opts.col - 1)
        local right = opts.line:sub(opts.col + 2, opts.col + 3)
        return left == '{%' and right == '%}'
      end),
}
-- vim: ts=2 sts=2 sw=2 et
