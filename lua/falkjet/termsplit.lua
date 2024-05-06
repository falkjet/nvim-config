local M = {}


function M.termsplit()
  local buf = vim.api.nvim_create_buf(false, false)
  local function au(ev, fun)
    vim.api.nvim_create_autocmd(ev, { buffer = buf, callback = fun })
  end
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_open_win(buf, true, {
    split = (vim.fn.winwidth(win) < vim.fn.winheight(win) * 2) and "below" or "right"
  })
  au("TermOpen", function() vim.cmd.startinsert() end)
  au("TermClose", function() vim.cmd.bw() end)
  au("BufEnter", function() vim.cmd.startinsert() end)
  au("BufWinEnter", function() vim.cmd.startinsert() end)
  vim.opt_local.number = false
  vim.fn.termopen("$SHELL", { buf = buf, })
end

function M.setup(opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(opts.cmd or "Term", M.termsplit, {})
  vim.keymap.set({ 'n', 'i', 't' }, opts.keybind or '<m-return>', '<cmd>Term<cr>')
end

M.setup {}

return M
