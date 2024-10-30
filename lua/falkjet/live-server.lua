-- [nfnl] Compiled from fnl/falkjet/live-server.fnl by https://github.com/Olical/nfnl, do not edit.
local job_id = nil
local port = nil
local function on_exit(id, status, event)
  job_id = nil
  port = nil
  return nil
end
local function start()
  if (port == nil) then
    port = math.floor(((math.random() * (65535 - 1024)) + 1024))
    local command = ("live-server --no-browser --port=%d"):format(port)
    job_id = vim.fn.jobstart(command, {on_exit = on_exit})
    return print(job_id)
  else
    return nil
  end
end
local function open(filename)
  local filepath
  if (filename == nil) then
    filepath = vim.fn.expand("%")
  else
    filepath = filename
  end
  start()
  print(vim.inspect(filepath))
  return vim.fn.jobstart({"xdg-open", ("http://localhost:%d/%s"):format(port, filepath)})
end
return {start = start, open = open}
