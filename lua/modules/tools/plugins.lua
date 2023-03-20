-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').package
local conf = require('modules.tools.config')

plugin({ 'antoinemadec/FixCursorHold.nvim', event = 'BufReadPre' })

plugin({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
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
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
})

--plugin({
--  'andymass/vim-matchup',
--  event = 'BufRead',
--  config = function()
--    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
--  end,
--})

plugin({
  'JuanZoran/Trans.nvim',
  run = 'bash ./install.sh',
  cmd = { 'Translate' },
  dependencies = { 'kkharji/sqlite.lua' },
  -- 如果你不需要任何配置的话, 可以直接按照下面的方式启动
  config = function()
    require('Trans').setup({
      -- your configuration here
    })
  end,
})

plugin({
  'folke/todo-comments.nvim',
  event = 'BufRead',
  config = function()
    require('todo-comments').setup()
  end,
})

-- plugin({
--   'tpope/vim-surround',
--   event = 'BufRead',
--   keys = { 'c', 'd', 'b' },
-- })

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
  cmd = { 'SudaWrite', 'SudaRead' },
  config = function()
    vim.g.suda_smart_edit = 1
  end,
})

plugin({
  'sindrets/winshift.nvim',
  cmd = 'WinShift',
})

plugin({
  'Shatur/neovim-session-manager',
  config = conf.session_manager,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
})

plugin({
  'folke/which-key.nvim',
  event = 'BufWinEnter',
  config = conf.which_key,
})

plugin({
  'numToStr/Comment.nvim',
  event = 'BufRead',
  config = function()
    require('Comment').setup()
  end,
})

plugin({
  'tpope/vim-repeat',
  event = 'BufRead',
})

-- plugin({
--   'glacambre/firenvim',
--   run = function()
--     vim.fn['firenvim#install'](0)
--   end,
-- })

plugin({
  'iamcco/markdown-preview.nvim',
  run = 'cd app && npm install',
  setup = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
})

plugin({
  'dhruvasagar/vim-table-mode',
  --ft = { 'markdown' },
  cmd = { 'TableModeToggle' },
  config = conf.table_modle,
})

vim.cmd("let g:targets_aiAI = 'arAR'")
plugin({
  'wellle/targets.vim',
  event = 'BufRead',
  config = function()
    vim.cmd([[
      autocmd User targets#mappings#user call targets#mappings#extend({
          \ 's': { 'separator': [{'d':','}, {'d':'.'}, {'d':';'}, {'d':':'}, {'d':'+'}, {'d':'-'},
          \                      {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
          \                      {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'}] },
          \ '@': {
          \     'pair':      [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
          \     'quote':     [{'d':"'"}, {'d':'"'}, {'d':'`'}],
          \     'tag':       [{}],
          \     },
          \ })
      omap q r@
      xmap q r@
    ]])
  end,
})

