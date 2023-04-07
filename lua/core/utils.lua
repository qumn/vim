local model = {}
local keymap = require('core.keymap')

function nmorqw(nm, qw)
  return vim.g.is_norman and nm or qw
end
model.nmorqw = nmorqw

local image_suffix = { 'png', 'gif' }
-- get file name under cursor
function model.get_file_under_cursor()
  local Path = require('plenary.path')
  local line = vim.fn.getline('.')
  -- search the first '.' or '/' on the line
  local start_pos = vim.fn.searchpos('\\./\\|/', 'bcnW', vim.fn.line('.'))[2]

  for _, suffix in ipairs(image_suffix) do
    local end_pos = vim.fn.searchpos('\\.' .. suffix, 'cnW', vim.fn.line('.'))[2]
    if end_pos ~= 0 then
      local file_path = string.sub(line, start_pos, end_pos + suffix:len())
      local path = Path:new(file_path)
      return path:absolute()
    end
  end
  return nil
end

function render_image()
  local file_path = model.get_file_under_cursor()
  local command = ""
  command = "silent !wezterm cli split-pane -- bash -c 'convert "
  command = command .. file_path
  command = command .. " -geometry 900x2400 sixel:-; read'"
  print("command: " .. command)
  --vim.cmd
  vim.api.nvim_command(command)
end

return model
