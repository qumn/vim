-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.lang.config')

plugin({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  after = 'telescope.nvim',
  config = conf.nvim_treesitter,
})

plugin({
  'nvim-treesitter/nvim-treesitter-textobjects',
  after = 'nvim-treesitter',
})

plugin({
  'p00f/nvim-ts-rainbow',
  after = 'nvim-treesitter',
})

plugin({
  'kevinhwang91/nvim-ufo',
  requires = 'kevinhwang91/promise-async',
  after = 'nvim-lspconfig',
  config = conf.ufo,
})


plugin({
  'kkoomen/vim-doge',
  cmd = 'DogeGenerate',
  run = ':call doge#install()',
  config = conf.doge
})
