-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
require('keymap.gui')
local key = require('core.keymap')
local nmap, vmap = key.nmap, key.vmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

local jump_only_error_next = function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end

local jump_only_error_prev = function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end
-- usage of plugins
nmap({
  -- packer
  { '<Leader>pu', cmd('PackerUpdate'), opts(noremap, silent) },
  { '<Leader>pi', cmd('PackerInstall'), opts(noremap, silent) },
  { '<Leader>pc', cmd('PackerCompile'), opts(noremap, silent) },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- nvimtree
  { '<Leader>e', cmd('NvimTreeFindFileToggle'), opts(noremap, silent) },
  -- Telescope
  { 's', '<Nop>', opts(noremap, silent) },
  { 'sb', cmd('Telescope buffers theme=get_ivy'), opts(noremap, silent) },
  { 'sa', cmd('Telescope live_grep theme=get_ivy'), opts(noremap, silent) },
  { 'sf', cmd('Telescope find_files theme=get_ivy'), opts(noremap, silent) },
  { 'so', cmd('Telescope oldfiles theme=get_ivy'), opts(noremap, silent) },
  { 'ss', cmd('Telescope lsp_document_symbols theme=get_ivy'), opts(noremap, silent) },
  { 'sS', cmd('Telescope lsp_workspace_symbols theme=get_ivy'), opts(noremap, silent) },
  { 'gc', cmd('Telescope git_commits theme=get_ivy'), opts(noremap, silent) },
  { 'sh', cmd('Telescope help_tags theme=get_ivy'), opts(noremap, silent) },
  { 'sp', cmd('Telescope project theme=get_ivy'), opts(noremap, silent) },
  { '<Leader>sk', cmd('Telescope keymaps theme=get_ivy'), opts(noremap, silent) },
  -- hop
  { 'sl', cmd('HopWordAC'), opts(noremap, silent) },
  { 'sh', cmd('HopWordBC'), opts(noremap, silent) },
  { 'sj', cmd('HopLineStartAC'), opts(noremap, silent) },
  { 'sk', cmd('HopLineStartBC'), opts(noremap, silent) },
  -- treehop
  { 'sm', cmd('lua require("tsht").move()'), opts(noremap, silent) },
  { 'sv', cmd('lua require("tsht").nodes()'), opts(noremap, silent) },
  -- other
  { '<Leader>c', cmd('bd'), opts(noremap, silent) },
  { '<Leader>h', cmd('nohlsearch'), opts(noremap, silent) },
  { '<Leader>w', cmd('w!'), opts(noremap, silent) },
  { '<Leader>tw', cmd('TranslateW'), opts(noremap) },
  -- lspsaga
  { 'gh', cmd('Lspsaga lsp_finder'), opts(noremap, silent) },
  { 'gr', cmd('Lspsaga rename'), opts(noremap, silent) },
  { 'gp', cmd('Lspsaga preview_definition'), opts(noremap, silent) },
  { 'gd', cmd('lua vim.lsp.buf.definition()'), opts(noremap, silent) },
  { '[e', cmd('Lspsaga diagnostic_jump_prev'), opts(noremap, silent) },
  { ']e', cmd('Lspsaga diagnostic_jump_next'), opts(noremap, silent) },
  { '<leader>ca', cmd('Lspsaga code_action'), opts(noremap, silent) },
  { '<leader>cd', cmd('Lspsaga show_line_diagnostics'), opts(noremap, silent) },
  { '<leader>cd', cmd('Lspsaga show_cursor_diagnostics'), opts(noremap, silent) },
  { '<Leader>gg', cmd('Lspsaga open_floaterm lazygit'), opts(noremap, silent) },
  { '[E', jump_only_error_prev, opts(silent) },
  { ']E', jump_only_error_next, opts(noremap, silent) },
  { '<leader>o', '<cmd>LSoutlineToggle<CR>', opts(noremap, silent) },
  { '<leader>o', cmd('LSoutlineToggle'), opts(noremap, silent) }, -- outline use `o` to jump
  { 'K', cmd('Lspsaga hover_doc'), opts(noremap, silent) },
  -- gitsigns
  { ']g', cmd('lua require"gitsigns".next_hunk()'), opts(noremap, silent) },
  { '[g', cmd('lua require"gitsigns".prev_hunk()'), opts(noremap, silent) },
  { '<leader>gs', cmd('lua require"gitsigns".stage_hunk()'), opts(noremap, silent) },
  { '<leader>gu', cmd('lua require"gitsigns".undo_stage_hunk()'), opts(noremap, silent) },
  { '<leader>gr', cmd('lua require"gitsigns".reset_hunk()'), opts(noremap, silent) },
  { '<leader>gp', cmd('lua require"gitsigns".preview_hunk()'), opts(noremap, silent) },
  { '<leader>gb', cmd('lua require"gitsigns".blame_line()'), opts(noremap, silent) },
})

vmap({
  { '<leader>ca', cmd('<C-U>Lspsaga range_code_action'), opts(noremap, silent) },
})
