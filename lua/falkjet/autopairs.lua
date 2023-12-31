local npairs     = require 'nvim-autopairs'
local Rule       = require 'nvim-autopairs.rule'

local pluginopts = {
  disable_filetype = { "TelescopePrompt", "vim" },
}

npairs.setup(pluginopts)
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
}
for _, bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(function() return false end)
        :with_move(function(opts)
          return opts.prev_char:match('.%' .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2])
  }
end

npairs.add_rules {
  Rule("%", "%"):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return pair == "{}"
  end),
  Rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 2, opts.col + 1)
    return pair == "{%%}"
  end)
}
-- vim: ts=2 sts=2 sw=2 et
