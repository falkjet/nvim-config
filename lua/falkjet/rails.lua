-- [nfnl] Compiled from fnl/falkjet/rails.fnl by https://github.com/Olical/nfnl, do not edit.
local function get_ts_parser(buffer, lang)
  return vim.treesitter.get_parser(buffer, lang, {})
end
local function get_ts_root(buffer, lang)
  local parser = get_ts_parser(buffer, lang)
  local tree = parser:parse()[1]
  return tree:root()
end
local function get_cursor(win)
  local _let_1_ = vim.api.nvim_win_get_cursor(win)
  local line = _let_1_[1]
  local col = _let_1_[2]
  return {(line - 1), col}
end
local function get_ts_node_at_cursor(win, lang, node)
  local buffer = vim.api.nvim_win_get_buf(win)
  local _local_2_ = get_cursor(win)
  local line = _local_2_[1]
  local col = _local_2_[2]
  local node0 = (node or get_ts_root(buffer))
  return node0:named_descendant_for_range(line, col, line, col)
end
local function get_ts_path_to_cursor(win, lang)
  local buffer = vim.api.nvim_win_get_buf(win)
  local node = get_ts_root(buffer)
  local target = get_ts_node_at_cursor(win, lang, node)
  local path = {}
  while (node ~= target) do
    node = node:child_with_descendant(target)
    table.insert(path, node)
  end
  return path
end
local function to_camel(name)
  local result
  local function _3_(c)
    return c:upper()
  end
  result = string.gsub(name, "[_-](%a)", _3_)
  return result
end
local function to_pascal(name)
  local name0 = to_camel(name)
  if (name0 == "") then
    return ""
  else
    return (string.upper(string.sub(name0, 1, 1)) .. string.sub(name0, 2))
  end
end
local function controller_info(win)
  local buffer = vim.api.nvim_win_get_buf(win)
  local filename = vim.api.nvim_buf_get_name(buffer)
  local project_path, name = string.match(filename, "(.*)/app/controllers/(.*)_controller.rb")
  if (project_path and name) then
    local _local_5_ = get_ts_path_to_cursor(win)
    local class = _local_5_[1]
    local _body = _local_5_[2]
    local method = _local_5_[3]
    if (class and (class:type() == "class") and (not method or (method:type() == "method"))) then
      local class_name = vim.treesitter.get_node_text(class:field("name")[1], buffer)
      local method_name = (method and vim.treesitter.get_node_text(method:field("name")[1], buffer))
      local class_controller_name = class_name:match("(.*)Controller$")
      if (class_controller_name and (class_controller_name == to_pascal(name))) then
        return {project = project_path, controller = name, filename = filename, action = method_name}
      else
        return nil
      end
    else
      return nil
    end
  else
    return nil
  end
end
local function view_info(win)
  local buffer = vim.api.nvim_win_get_buf(win)
  local filename = vim.api.nvim_buf_get_name(buffer)
  local project, controller, action = string.match(filename, "(.*)/app/views/(.*)/(.*).html.erb")
  if (project and controller and action) then
    return {project = project, controller = controller, action = action}
  else
    return nil
  end
end
local function _10_()
  local controller_info0 = controller_info(0)
  local view_info0 = view_info(0)
  if (controller_info0 and controller_info0.action) then
    local info = controller_info0
    local view_file = (info.project .. "/app/views/" .. info.controller .. "/" .. info.action .. ".html.erb")
    return vim.cmd.edit(view_file)
  elseif view_info0 then
    local info = view_info0
    local controller_file = (info.project .. "/app/controllers/" .. info.controller .. "_controller.rb")
    return vim.cmd.edit(controller_file)
  else
    return nil
  end
end
return vim.api.nvim_create_user_command("RailsView", _10_, {})
