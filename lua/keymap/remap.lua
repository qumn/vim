-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend some vim mode key defines in this file

local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, smap, vmap, amap, omap =
  keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.smap, keymap.vmap, keymap.amap, keymap.omap
local silent, noremap, expr, remap = keymap.silent, keymap.noremap, keymap.expr, keymap.remap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '
-- require('keymap.smarttab')

-- imap({
--   -- tab key
--   { '<TAB>', _G.smart_tab, opts(expr, silent, remap) },
--   { '<S-TAB>', _G.smart_shift_tab, opts(expr, silent, remap) },
--   { '<C-h>', '<Bs>', opts(noremap) },
--   --{ '<CR>', _G.smart_return, opts(expr, silent, remap) },
-- })

-- smap({
--   { '<TAB>', _G.smart_tab, opts(expr, silent, remap) },
--   { '<S-TAB>', _G.smart_shift_tab, opts(expr, silent, remap) },
-- })

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  {
    nmorqw('I', 'K'),
    cmd('Lspsaga hover_doc'),
    opts(noremap, silent),
  },
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  { nmorqw('Y', 'H'), '^', opts(noremap, silent) },
  { nmorqw('O', 'L'), '$', opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  -- { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- window jump
  { nmorqw('gy', 'gh'), cmd('BufferLineCyclePrev'), opts(noremap, silent) },
  { nmorqw('go', 'gl'), cmd('BufferLineCycleNext'), opts(noremap, silent) },
  { '==', cmd("lua require'keymap.format'.format()"), opts(noremap, silent) },
})

-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })

vmap({
  { 'H', '^', opts(noremap, silent) },
  { 'L', '$', opts(noremap, silent) },
})

-- gui specialize config
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

nmap({ nmorqw('<c-y>', '<c-h>'), cmd('lua require("tmux").move_left()'), opts(noremap, silent) })
nmap({ nmorqw('<c-n>', '<c-j>'), cmd('lua require("tmux").move_bottom()'), opts(noremap, silent) })
if vim.g.neovide then
  nmap({ nmorqw('<C-i>', '<c-k>'), cmd('lua require("tmux").move_top()'), opts(noremap, silent) })
else
  nmap({ nmorqw('<M-\\>', '<c-k>'), cmd('lua require("tmux").move_top()'), opts(noremap, silent) })
end
nmap({ nmorqw('<c-o>', '<c-l>'), cmd('lua require("tmux").move_right()'), opts(noremap, silent) })
vmap({ 'P', '"0p', opts(noremap, silent) })
omap({ 'x', '<Plug>(leap-forward-till)', opts(noremap, silent) })
xmap({ 'x', '<Plug>(leap-forward-till)', opts(noremap, silent) })
omap({ 'X', '<Plug>(leap-backward-till)', opts(noremap, silent) })
xmap({ 'X', '<Plug>(leap-backward-till)', opts(noremap, silent) })

