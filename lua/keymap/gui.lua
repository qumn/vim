-- gui specialize config 
local key = require('core.keymap')
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local nmap = key.nmap
vim.g.gui_font_default_size = 18
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FiraCode Nerd Font"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
nmap({"<C-=>", function() ResizeGuiFont(1)  end, opts(noremap, silent)})
nmap({"<C-->", function() ResizeGuiFont(-1) end, opts(noremap, silent)})
