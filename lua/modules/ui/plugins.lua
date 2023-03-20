-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').package
local conf = require('modules.ui.config')

plugin({ 'glepnir/dashboard-nvim', config = conf.dashboard })

--plugin({
--  'glepnir/galaxyline.nvim',
--  branch = 'main',
--  config = conf.galaxyline,
--  requires = 'kyazdani42/nvim-web-devicons',
--})
plugin({
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = conf.lualine,
})

plugin({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeFindFileToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({
  'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({
  'catppuccin/nvim',
  as = 'catppuccin',
  config = conf.catppuccin,
})

plugin({
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns,
  dependencies = { 'nvim-lua/plenary.nvim' },
})

vim.g.gitblame_date_format = '%r'
plugin({
  'f-person/git-blame.nvim',
  event = 'BufRead',
  config = function() end,
})

plugin({
  'karb94/neoscroll.nvim',
  event = 'WinScrolled',
  config = function()
    require('neoscroll').setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
    })
  end,
})

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

plugin({
  'gelguy/wilder.nvim',
  event = 'CmdlineEnter',
  dependencies = {
    'romgrk/fzy-lua-native',
  },
  config = conf.wilder
})
