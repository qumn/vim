-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

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
  -- hop
  { "sl", cmd("HopWordAC"), opts(noremap, silent)},
  { "sh", cmd("HopWordBC"), opts(noremap, silent)},
  { "sj", cmd("HopLineStartAC"), opts(noremap, silent)},
  { "sk", cmd("HopLineStartBC"), opts(noremap, silent)},
  -- treehop
  { 'sm', cmd('lua require("tsht").move()'), opts(noremap, silent)},
  { 'sv', cmd('lua require("tsht").nodes()'), opts(noremap, silent)},
  -- other
  { "<Leader>c", cmd('bd'), opts(noremap, silent) },
})
