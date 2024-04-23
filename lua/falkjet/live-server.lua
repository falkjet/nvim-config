local M = {}

function M.start()
  if M.port ~= nil then return end
  M.port = math.floor(math.random() * (65535 - 1024) + 1024)
  local command = ('live-server --no-browser --port=%d'):format(M.port)
  M.jobid = vim.fn.jobstart(command)
end

function M.open(filename)
  if filename == nil then filename = vim.fn.expand('%') end
  M.start()
  print(vim.inspect(filename))
  vim.fn.jobstart({
    'xdg-open',
    ('http://localhost:%d/%s'):format(M.port, filename)
  })
end

return M
