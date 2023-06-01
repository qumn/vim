-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').package
local conf = require('modules.lang.config')

plugin({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/playground'
  }
})

plugin({
  'nvim-treesitter/nvim-treesitter-textobjects',
  event = 'BufRead',
  dependencies = {
    'nvim-treesitter/nvim-treesitter'
  }
})

plugin({
  'p00f/nvim-ts-rainbow',
  event = 'BufRead',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
})

plugin({
  'simrat39/symbols-outline.nvim',
  cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose' },
  config = conf.symbols_outline,
})

plugin({
  'kevinhwang91/nvim-ufo',
  event = 'BufRead',
  config = conf.ufo,
  dependencies = {
    'nvim-lspconfig',
    'kevinhwang91/promise-async',
  },
})

-- plugin({
--   'kkoomen/vim-doge',
--   --cmd = 'DogeGenerate',
--   run = ':call doge#install()',
--   config = conf.doge,
-- })
