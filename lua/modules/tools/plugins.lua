-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({ 'antoinemadec/FixCursorHold.nvim', event = 'BufReadPre' })

plugin({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/popup.nvim', opt = true },
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
    { 'nvim-telescope/telescope-project.nvim', opt = true },
  },
})

plugin({
  'mfussenegger/nvim-treehopper',
  event = 'BufRead',
})

plugin({
  'phaazon/hop.nvim',
  cmd = { 'HopWordAC', 'HopWordBC', 'HopLineStartAC', 'HopLineStartBC' },
  config = function()
    require('hop').setup()
  end,
})
plugin({
  'ahmedkhalf/project.nvim',
  config = conf.project,
})

plugin({
  'aserowy/tmux.nvim',
  event = 'BufRead',
  config = conf.tmux,
})

plugin({
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  requires = {
    { 'nvim-lua/plenary.nvim', opt = true },
  },
})

plugin({
  'andymass/vim-matchup',
  event = 'BufRead',
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  end,
})

plugin({
  'voldikss/vim-translator',
  cmd = 'TranslateW',
  config = function()
    vim.g.translator_default_engines = { 'bing', 'haici' }
  end,
})

plugin({
  'folke/todo-comments.nvim',
  event = 'BufRead',
  config = function()
    require('todo-comments').setup()
  end,
})

plugin({
  'tpope/vim-surround',
  event = 'BufRead',
  keys = { 'c', 'd', 'y' },
})

plugin({
  'junegunn/vim-easy-align',
  event = 'BufRead',
  config = function()
    vim.cmd([[
      " Start interactive EasyAlign in visual mode (e.g. vipga)
      xmap ga <Plug>(EasyAlign)

      " Start interactive EasyAlign for a motion/text object (e.g. gaip)
      nmap ga <Plug>(EasyAlign)
    ]])
  end,
})

plugin({
  'lambdalisue/suda.vim',
  cmd = 'SudaWrite',
  config = function()
    vim.g.suda_smart_edit = 1
  end,
})

plugin({
  'sindrets/winshift.nvim',
  cmd = 'WinShift',
})
