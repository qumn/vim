-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').package
local conf = require('modules.completion.config')

local enable_lsp_filetype = {
  'lua',
  'rust',
  'c',
  'cpp',
  'sh',
  'json',
  'javascript',
  'java',
  'vue',
  'typescript',
}

plugin({
  'neovim/nvim-lspconfig',
  ft = enable_lsp_filetype,
  config = conf.nvim_lsp,
  dependencies = {
    {
      'glepnir/lspsaga.nvim',
      config = conf.lspsaga,
      dependencies = {
        'kyazdani42/nvim-web-devicons',
      },
    },
  },
})

plugin({
  'simrat39/rust-tools.nvim',
  ft = 'rust',
})

plugin({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
  },
})

plugin({
  'L3MON4D3/LuaSnip',
  event = 'InsertCharPre',
  config = conf.lua_snip,
})

plugin({
  'williamboman/mason.nvim',
  config = conf.mason,
})

-- plugin({
--   'glepnir/lspsaga.nvim',
--   -- branch = "main",
--   after = 'nvim-lspconfig',
--   requires = 'kyazdani42/nvim-web-devicons',
--   config = conf.lspsaga,
-- })

plugin({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = conf.auto_pairs,
})
plugin({
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-treesitter.configs').setup({
      autotag = {
        enable = true,
      },
    })
  end,
})

plugin({
  'jose-elias-alvarez/null-ls.nvim',
  event = 'BufRead',
  config = conf.null_ls,
})

plugin({
  'ray-x/lsp_signature.nvim',
  event = 'InsertEnter',
  config = conf.lsp_signature,
})

plugin({
  'mfussenegger/nvim-jdtls',
  ft = 'java',
})
