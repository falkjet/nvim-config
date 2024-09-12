local M = {}

-- map of processes watching files keys are absolute file paths
local watch_processes = {}

---@param path string
local function start_watch_process(path)
  local command = ('typst watch %s'):format(vim.fn.shellescape(path))
  local jobid = vim.fn.jobstart(command, {
    on_exit = function()
      watch_processes[path] = nil
    end
  })
  if jobid == 0 then
    return -- Did not start process or something
  end
  watch_processes[path] = jobid
end

---@param path string | nil
function M.run_file(path)
  local typst_file = path or vim.fn.expand '%:p';

  if not watch_processes[typst_file] then
    start_watch_process(typst_file)
  end
end

---@param path string | nil
---@param retry_count integer | nil
function M.view_file(path, retry_count, retry_delay)
  retry_count = retry_count or 10
  retry_delay = (retry_delay or 50) * 2 -- exponential backoff
  local pdf_file = path or vim.fn.expand '%:p:r' .. '.pdf'

  local open_command = ('xdg-open %s'):format(vim.fn.shellescape(pdf_file))
  vim.fn.jobstart(open_command, {
    detach = true,
    on_exit = function(_, code)
      if code ~= 0 and retry_count > 0 then
        vim.defer_fn(function() M.view_file(path, retry_count - 1) end, 300)
      end
    end
  })
end

return M
