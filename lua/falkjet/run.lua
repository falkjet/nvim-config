local function vimcmd(cmd)
  return function()
    vim.cmd(cmd)
  end
end

local function is_empty(table)
  for _ in pairs(table) do
    return false
  end
  return true
end

local function tab_terminal(cmd, opts)
  local tabpage = vim.api.nvim_get_current_tabpage()
  local background = false
  if opts ~= nil then
    if opts.background ~= nil then
      background = opts.background
    end
    opts.background = nil
  end
  vim.cmd [[ tabnew ]]
  vim.opt.number = false
  vim.opt.relativenumber = false

  local result
  if opts == nil or is_empty(opts) then
    result = vim.fn.termopen(cmd)
  else
    result = vim.fn.termopen(cmd, opts)
  end

  if background then
    vim.api.nvim_set_current_tabpage(tabpage)
  else
    vim.cmd [[ startinsert ]]
  end

  return result
end

local filetypes = {
  tex = { run_file = vimcmd [[ VimtexCompile ]] },
  markdown = { run_file = vimcmd [[ MarkdownPreview ]] },
  python = {
    run_file = function()
      tab_terminal { 'python', vim.fn.expand '%' }
    end
  },
  maude = {
    run_file = function()
      tab_terminal(
        { 'sh', '-c', 'echo "$0"; maude -no-banner "$0" #</dev/null', vim.fn.expand '%' },
        { env = { MAUDE_LIB = '/usr/share/maude' }, stdin = nil }
      )
      vim.api.nvim_create_autocmd({ 'TermClose' }, {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
          vim.cmd [[ bw! ]]
        end,
      })
      vim.cmd [[ startinsert ]]
    end
  },
  html = {
    run_file = function()
      require 'falkjet.live-server'.open(vim.fn.expand '%')
    end
  },
  bqn = { run_file = function() tab_terminal { 'cbqn', vim.fn.expand '%' } end },
  racket = { run_file = function() tab_terminal { 'racket', vim.fn.expand '%' } end },
}

local function run_file()
  local ft = vim.opt.filetype:get()
  if ft == '' then
    print('No filetype detected')
    return
  end
  local run_fn = (filetypes[ft] or {}).run_file
  if run_fn == nil then
    print("don't know how to run '" .. ft .. "' file")
    return
  end
  run_fn()
end

vim.api.nvim_create_user_command('RunFile', run_file, { nargs = 0 })
vim.keymap.set('n', '<F5>', run_file, { desc = 'Run File' })

local function sh_cmd(opts)
  tab_terminal({ 'sh', '-c', opts.args })
end

vim.api.nvim_create_user_command('Sh', sh_cmd, { nargs = 1, complete = 'shellcmd' })
vim.api.nvim_create_user_command('SH', sh_cmd, { nargs = 1, complete = 'shellcmd' })


-- Projects
local defaults = {
  run_cmd = 'echo ERR: No command configured!; exit 1'
}

require 'neoconf.plugins'.register {
  name = 'project',
  on_schema = function(schema)
    schema:import('project', defaults)
    schema:set('project.run_cmd', {
      description = 'Command to run project',
      anyOf = {
        { type = 'string' },
        { type = 'array', items = { type = "string" } },
      }
    })
  end
}

local Neoconf = require 'neoconf'

local function run_project()
  local cmd = Neoconf.get 'project.run_cmd'
  if type(cmd) == 'nil' then
    print("No command configured")
    return
  end
  if type(cmd) == 'string' then
    cmd = { 'sh', '-c', cmd }
  end
  tab_terminal(cmd)
end

local function run_project_in_background()
  local cmd = Neoconf.get 'project.run_cmd'
  if type(cmd) == 'nil' then
    print("No command configured")
    return
  end
  if type(cmd) == 'string' then
    cmd = { 'sh', '-c', cmd }
  end
  tab_terminal(cmd, { background = true })
end

vim.api.nvim_create_user_command('Run', run_project, { nargs = 0 })
vim.keymap.set('n', '<F9>', run_project, { desc = 'Run Project' })
vim.keymap.set('n', '<F21>', run_project_in_background, { desc = 'Run Project in Background' })

-- vim: ts=2 sts=2 sw=2 et
