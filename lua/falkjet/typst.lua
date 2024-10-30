-- [nfnl] Compiled from fnl/falkjet/typst.fnl by https://github.com/Olical/nfnl, do not edit.
local watch_processes = {}
local function start_watch_process(path)
  local command = ("typst watch %s"):format(vim.fn.shellescape(path))
  local jobid
  local function _1_()
    watch_processes[path] = nil
    return nil
  end
  jobid = vim.fn.jobstart(command, {on_exit = _1_})
  if (jobid ~= 0) then
    watch_processes[path] = jobid
    return nil
  else
    return nil
  end
end
local function run_file(path)
  local typst_file = (path or vim.fn.expand("%:p"))
  if not watch_processes[typst_file] then
    return start_watch_process(typst_file)
  else
    return nil
  end
end
local function view_file(path, retry_count, retry_delay)
  retry_count = (retry_count or 10)
  retry_delay = ((retry_delay or 50) * 2)
  local pdf_file = (path or (vim.fn.expand("%:p:r") .. ".pdf"))
  local open_command = ("xdg-open %s"):format(vim.fn.shellescape(pdf_file))
  local function on_exit(_, code)
    if ((code ~= 0) and (retry_count > 0)) then
      local function _4_()
        return view_file(path, (retry_count - 1))
      end
      return vim.defer_fn(_4_, 300)
    else
      return nil
    end
  end
  return vim.fn.jobstart(open_command, {detach = true, on_exit = on_exit})
end
return {["run-file"] = run_file, run_file = run_file, ["view-file"] = view_file, view_file = view_file}
