-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend some vim mode key defines in this file

local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, smap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.smap, keymap.vmap
local silent, noremap, expr, remap = keymap.silent, keymap.noremap, keymap.expr, keymap.remap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '
require('keymap.smarttab')

imap({
  -- tab key
  { '<TAB>', _G.smart_tab, opts(expr, silent, remap) },
  { '<S-TAB>', _G.smart_shift_tab, opts(expr, silent, remap) },
  { '<C-h>', '<Bs>', opts(noremap) },
})

smap({
  { '<TAB>', _G.smart_tab, opts(expr, silent, remap) },
  { '<S-TAB>', _G.smart_shift_tab, opts(expr, silent, remap) },
})

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  {
    'K',
    function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.cmd('Lspsaga hover_doc')
      end
    end,
    opts(noremap, silent),
  },
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  { 'H', '^', opts(noremap, silent) },
  { 'L', '$', opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- window jump
  { 'E', cmd('BufferLineCyclePrev'), opts(noremap, silent) },
  { 'R', cmd('BufferLineCycleNext'), opts(noremap, silent) },
  { '==', cmd("lua require'keymap.format'.format()"), opts(noremap, silent) },
})

-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })

vmap({
  { 'H', '^', opts(noremap, silent) },
  { 'L', '$', opts(noremap, silent) },
})
-- gui specialize config
vim.g.gui_font_default_size = 18
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = 'FiraCode Nerd Font'

RefreshGuiFont = function()
  vim.opt.guifont = string.format('%s:h%s', vim.g.gui_font_face, vim.g.gui_font_size)
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
nmap({
  '<C-=>',
  function()
    ResizeGuiFont(1)
  end,
  opts(noremap, silent),
})
nmap({
  '<C-->',
  function()
    ResizeGuiFont(-1)
  end,
  opts(noremap, silent),
})
