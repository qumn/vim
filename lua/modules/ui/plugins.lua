-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').package
local conf = require('modules.ui.config')

plugin({
  'qumn/dashboard-nvim',
  config = conf.dashboard,
  dependencies = {
    'Shatur/neovim-session-manager',
  },
})

-- plugin({
--   'Shatur/neovim-session-manager',
--   commit = 'e7a2cbf56b5fd3a223f2774b535499fc62eca6ef',
--   config = conf.session_manager,
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--   },
-- })

--plugin({
--  'glepnir/galaxyline.nvim',
--  branch = 'main',
--  config = conf.galaxyline,
--  requires = 'kyazdani42/nvim-web-devicons',
--})
plugin({
  'nvim-lualine/lualine.nvim',
  event = 'BufReadPre',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = conf.lualine,
  dependencies = { 'zbirenbaum/copilot.lua' },
})

plugin({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeFindFileToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({
  'qumn/bufferline.nvim',
  event = 'BufReadPre',
  config = conf.nvim_bufferline,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({
  'catppuccin/nvim',
  as = 'catppuccin',
  config = conf.catppuccin,
})

vim.g.everforest_background = 'hard'
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_diagnostic_virtual_text = 'colored'
plugin({
  'sainnhe/everforest',
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function() end,
})

plugin({ 'ellisonleao/gruvbox.nvim', priority = 1000 })
plugin({
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
})

-- plugin({
--   'lewis6991/gitsigns.nvim',
--   event = { 'BufRead', 'BufNewFile' },
--   config = conf.gitsigns,
--   dependencies = { 'nvim-lua/plenary.nvim' },
-- })

vim.g.gitblame_date_format = '%r'
plugin({
  'f-person/git-blame.nvim',
  event = 'BufRead',
  config = function() end,
})

-- plugin({
--   'karb94/neoscroll.nvim',
--   event = 'WinScrolled',
--   config = function()
--     require('neoscroll').setup({
--       -- All these keys will be mapped to their corresponding default scrolling animation
--       mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-e>', 'zt', 'zz', 'zb' },
--       hide_cursor = true, -- Hide cursor while scrolling
--       stop_eof = true, -- Stop at <EOF> when scrolling downwards
--       use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
--       respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
--       cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
--       easing_function = nil, -- Default easing function
--       pre_hook = nil, -- Function to run before the scrolling animation starts
--       post_hook = nil, -- Function to run after the scrolling animation ends
--     })
--   end,
-- })

plugin({
  'stevearc/dressing.nvim',
  event = 'BufRead',
})

plugin({
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
  config = conf.indent_blankline,
})

plugin({
  'NvChad/nvim-colorizer.lua',
  event = 'BufRead',
  config = function()
    require('colorizer').setup()
  end,
})

-- plugin({
--   'folke/noice.nvim',
--   -- event = 'VeryLazy',
--   event = 'BufReadPost',
--   opts = {},
--   config = function()
--     require('noice').setup({
--       cmdline = {
--         enabled = not vim.g.neovide,
--       },
--       messages = {
--         -- NOTE: If you enable messages, then the cmdline is enabled automatically.
--         -- This is a current Neovim limitation.
--         enabled = not vim.g.neovide,
--       },
--       lsp = {
--         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--         override = {
--           ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
--           ['vim.lsp.util.stylize_markdown'] = true,
--           ['cmp.entry.get_documentation'] = true,
--         },
--         signature = {
--           enabled = true,
--           auto_open = {
--             enabled = false,
--             trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
--           },
--         },
--       },
--       -- you can enable a preset for easier configuration
--       presets = {
--         bottom_search = true, -- use a classic bottom cmdline for search
--         command_palette = true, -- position the cmdline and popupmenu together
--         long_message_to_split = true, -- long messages will be sent to a split
--         inc_rename = true, -- enables an input dialog for inc-rename.nvim
--         lsp_doc_border = true, -- add a border to hover docs and signature help
--       },
--     })
--   end,
--   dependencies = {
--     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--     'MunifTanjim/nui.nvim',
--     -- OPTIONAL:
--     --   `nvim-notify` is only needed, if you want to use the notification view.
--     --   If not available, we use `mini` as the fallback
--     'rcarriga/nvim-notify',
--   },
-- })

-- if vim.g.neovide then
--   plugin({
--     'gelguy/wilder.nvim',
--     event = 'CmdlineEnter',
--     dependencies = {
--       'romgrk/fzy-lua-native',
--     },
--     config = conf.wilder,
--   })
-- end

plugin({
  'glepnir/porcelain.nvim',
})

plugin({
  'glepnir/flybuf.nvim',
  cmd = 'FlyBuf',
  config = function()
    require('flybuf').setup({
      hotkey = 'asetgyniohwdfkjurzcvbpm', -- hotkye
      border = 'single', -- border
      quit = 'q', -- quit flybuf window
      mark = 'l', -- mark as delet or cancel delete
      delete = 'x', -- delete marked buffers or buffers which cursor in
    })
  end,
})
