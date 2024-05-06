local function dev()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = buf,
    callback = function() vim.cmd.luafile(vim.fn.expand("%")) end
  })

  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = buf,
    callback = function() vim.cmd 'w' end
  })

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    callback = function() vim.cmd 'w' end
  })
  vim.cmd 'w'
end
vim.api.nvim_create_user_command("Dev", dev, {})
