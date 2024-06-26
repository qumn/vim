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
    'nvim-telescope/telescope-project.nvim',
  },
})

-- plugin({
--   'mfussenegger/nvim-treehopper',
--   event = 'BufRead',
-- })

-- plugin({
--   'phaazon/hop.nvim',
--   cmd = { 'HopWordAC', 'HopWordBC', 'HopLineStartAC', 'HopLineStartBC' },
--   config = function()
--     require('hop').setup()
--   end,
-- })

-- plugin({
--   'ggandor/leap.nvim',
--   event = { 'BufRead', 'BufNewFile' },
--   config = function()
--     require('leap').setup({
--       safe_labels = {
--         't',
--         'f',
--         'u',
--         'h',
--         'j',
--         'x',
--         'r',
--         'l',
--         'k',
--         ';',
--         'T',
--         'F',
--         'U',
--         'H',
--         'J',
--         'X',
--         'R',
--         'L',
--         'K',
--       },
--     })
--     vim.api.nvim_set_hl(0, 'LeapMatch', {
--       -- For light themes, set to 'black' or similar.
--       fg = 'white',
--       bold = true,
--       nocombine = true,
--     })
--     -- Of course, specify some nicer shades instead of the default "red" and "blue".
--     vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
--       fg = '#F38BA8',
--       bold = true,
--       nocombine = true,
--     })
--     vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
--       fg = '#89DCEB',
--       bold = true,
--       nocombine = true,
--     })
--   end,
-- })

-- plugin({
--   'ahmedkhalf/project.nvim',
--   config = conf.project,
-- })

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
  run = function()
    require('Trans').install()
  end,
  cmd = { 'Translate' },
  dependencies = { 'kkharji/sqlite.lua' },
  -- 如果你不需要任何配置的话, 可以直接按照下面的方式启动
  config = function()
    require('Trans').setup({
      -- your configuration here
    })
  end,
})

-- vim.cmd([[let g:surround_no_mappings = 1]])
-- set global variable
vim.g.surround_no_mappings = 1
plugin({
  'tpope/vim-surround',
  event = 'BufRead',
  -- keys = { 'c', 'd', 'j' },
  config = function()
    vim.cmd([[
      nmap ds  <Plug>Dsurround
      nmap cs  <Plug>Csurround
      nmap cS  <Plug>CSurround
      nmap js  <Plug>Ysurround
      nmap jS  <Plug>YSurround
      nmap jss <Plug>Yssurround
      nmap jSs <Plug>YSsurround
      nmap jSS <Plug>YSsurround
      xmap S   <Plug>VSurround
      xmap gS  <Plug>VgSurround
      if !exists("g:surround_no_insert_mappings") || ! g:surround_no_insert_mappings
          if !hasmapto("<Plug>Isurround","i") && "" == mapcheck("<C-S>","i")
              imap    <C-S> <Plug>Isurround
          endif
          imap      <C-G>s <Plug>Isurround
          imap      <C-G>S <Plug>ISurround
      endif
  ]])
  end,
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
  cmd = { 'SudaWrite', 'SudaRead' },
  config = function()
    vim.g.suda_smart_edit = 1
  end,
})

plugin({
  'sindrets/winshift.nvim',
  cmd = 'WinShift',
  config = function()
    require('winshift').setup({
      keymaps = {
        win_move_mode = {
          ['y'] = 'left',
          ['n'] = 'down',
          ['i'] = 'up',
          ['o'] = 'right',
        },
      },
    })
  end,
})
plugin({
  'anuvyklack/windows.nvim',
  cmd = {
    'WindowsMaximize',
    'WindowsMaximizeVertically',
    'WindowsMaximizeHorizontally',
    'WindowsEqualize',
    'WindowsEnableAutowidth',
    'WindowsDisableAutowidth',
    'WindowsToggleAutowidth',
  },
  config = function()
    require('windows').setup()
  end,
  dependencies = {
    'anuvyklack/middleclass',
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

vim.cmd("let g:targets_aiAI = 'a`A~'")
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
      omap q `@
      xmap q `@
    ]])
  end,
})

plugin({
  {
    -- dir = '/Users/qumn/project/vim/neorg',
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    event = 'VeryLazy',
    cmd = 'Neorg',
    ft = 'norg',
    -- opts = {
    --   load = {
    --     ['core.concealer'] = {}, -- Adds pretty icons to your documents
    --     ['core.integrations.nvim-cmp'] = {},
    --     ['core.export'] = {},
    --     ['core.syntax'] = {},
    --     ['core.export.markdown'] = {},
    --     -- ['core.norg.completion'] = {
    --     --   config = {
    --     --     engine = 'nvim-cmp',
    --     --   },
    --     -- },
    --     ['core.dirman'] = { -- Manages Neorg workspaces
    --       config = {
    --         workspaces = {
    --           notes = '~/notes',
    --         },
    --       },
    --     },
    --   },
    -- },
    config = function()
      require('neorg').setup({
        load = {
          ['core.defaults'] = {},
          ['core.export'] = {},
          ['core.export.markdown'] = {
            config = {
              extensions = 'all',
            },
          },
          ['core.completion'] = { config = { engine = 'nvim-cmp' } },
          ['core.concealer'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/notes',
              },
            },
          },
        },
      })
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'mfussenegger/nvim-treehopper' },
      { 'nvim-neorg/neorg-telescope' },
    },
  },
})

-- plugin({
--   '3rd/image.nvim',
--   config = function()
--     -- default config
--     require('image').setup({
--       backend = 'kitty',
--       integrations = {
--         markdown = {
--           enabled = true,
--           clear_in_insert_mode = false,
--           download_remote_images = true,
--           only_render_image_at_cursor = false,
--           filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
--         },
--         neorg = {
--           enabled = true,
--           clear_in_insert_mode = false,
--           download_remote_images = true,
--           only_render_image_at_cursor = false,
--           filetypes = { 'norg' },
--         },
--       },
--       max_width = nil,
--       max_height = nil,
--       max_width_window_percentage = nil,
--       max_height_window_percentage = 50,
--       window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
--       window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
--       editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
--       tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
--       hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
--     })
--   end,
-- })

plugin({
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-t>]],
      shell = '/bin/zsh',
    })
  end,
})

-- plugin({
--   'folke/flash.nvim',
--   event = 'VeryLazy',
--   -- stylua: ignore
--   keys = {
--     { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
--     { "gS", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
--     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
--     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
--     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
--   },
--   config = function()
--     require('flash').setup({
--       labels = 'asetgyniohqwdfkjurlzxcvbpm',
--       char = {
--         enable = true,
--         highlight = { backdrop = false },
--       },
--       jump = {
--         autojump = false,
--       },
--       highlight = {
--         -- show a backdrop with hl FlashBackdrop
--         backdrop = false,
--       },
--     })
--   end,
-- })

-- Lua
plugin({
  'narutoxy/silicon.lua',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('silicon').setup({})
    vim.keymap.set('v', '<Leader>s', function()
      require('silicon').visualise_api()
    end)
  end,
})

plugin({
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '0.3.*',
  build = function()
    require('typst-preview').update()
  end,
})
