-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({
  'neovim/nvim-lspconfig',
  ft = { 'lua', 'rust', 'c', 'cpp', 'sh', 'json' },
  config = conf.nvim_lsp,
})

plugin({
  'simrat39/rust-tools.nvim',
})

plugin({
  'hrsh7th/nvim-cmp',
  event = 'BufReadPre',
  config = conf.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
  },
})

plugin({
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  config = conf.lua_snip,
})

plugin({
  'williamboman/mason.nvim',
  config = conf.mason,
})

plugin({
  'glepnir/lspsaga.nvim',
  -- branch = "main",
  after = 'nvim-lspconfig',
  config = conf.lspsaga,
})

plugin({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = conf.auto_pairs,
})

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  event = "BufRead",
  config = conf.null_ls,
})

plugin({
  'ray-x/lsp_signature.nvim',
  event = 'InsertEnter',
  config = conf.lsp_signature,
})
