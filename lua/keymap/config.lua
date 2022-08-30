-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend some vim mode key defines in this file

local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, smap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.smap
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
  { '<C-e>', '<End>', opts(noremap) },
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
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
  -- window jump
  { '<C-h>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', '<C-w>j', opts(noremap) },
  { '<C-k>', '<C-w>k', opts(noremap) },
  { 'E', cmd('BufferLineCyclePrev'), opts(noremap, silent) },
  { 'R', cmd('BufferLineCycleNext'), opts(noremap, silent) },
  { '==', cmd("lua require'keymap.format'.format()"), opts(noremap, silent) },
})


-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })



