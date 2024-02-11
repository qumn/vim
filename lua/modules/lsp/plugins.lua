-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').package
local conf = require('modules.lsp.config')

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
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-cmdline',
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

plugin({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = conf.auto_pairs,
})
plugin({
  'windwp/nvim-ts-autotag',
  event = 'BufRead',
  config = function()
    require('nvim-treesitter.configs').setup({
      autotag = {
        enable = true,
      },
    })
  end,
})

-- plugin({
--   'ray-x/lsp_signature.nvim',
--   event = 'InsertEnter',
--   config = conf.lsp_signature,
-- })

plugin({
  'mfussenegger/nvim-jdtls',
  ft = 'java',
})

plugin({
  'zbirenbaum/copilot.lua',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('copilot').setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<C-a>',
          next = nmorqw('<C-n>', '<C-j>'),
          prev = nmorqw('<C-i>', '<C-k>'),
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
    })
  end,
})

plugin({
  'akinsho/flutter-tools.nvim',
  ft = 'dart',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    require('flutter-tools').setup({
      outline = {
        open_cmd = 'topleft 40vnew',
      },
      lsp = {
        color = {
          enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = '■', -- the virtual text character to highlight
        },
      },
    })
  end,
})

plugin({
  'lvimuser/lsp-inlayhints.nvim',
  event = 'LspAttach',
  branch = 'anticonceal',
  config = function()
    require('lsp-inlayhints').setup()
    vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = 'LspAttach_inlayhints',
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require('lsp-inlayhints').on_attach(client, bufnr)
      end,
    })
  end,
})
