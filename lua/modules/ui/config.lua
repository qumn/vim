-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

function config.catppuccin()
  require('modules.ui.catppuccin')
end

function config.zephyr()
  vim.cmd('colorscheme zephyr')
end

function config.lualine()
  require('modules.ui.eviline')
end

function config.indent_blankline()
  require('indent_blankline').setup({
    char = '│',
    use_treesitter_scope = true,
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,
    filetype_exclude = {
      'dashboard',
      'DogicPrompt',
      'log',
      'fugitive',
      'gitcommit',
      'packer',
      'markdown',
      'json',
      'txt',
      'vista',
      'help',
      'todoist',
      'NvimTree',
      'git',
      'TelescopePrompt',
      'undotree',
    },
    buftype_exclude = { 'terminal', 'nofile', 'prompt' },
    context_patterns = {
      'class',
      'function',
      'method',
      'block',
      'list_literal',
      'selector',
      '^if',
      '^table',
      'if_statement',
      'while',
      'for',
    },
  })
end

function config.dashboard()
  local db = require('dashboard')
  db.setup({
    theme = 'hyper',
    config = {
      week_header = {
        enable = true,
      },
      exclude_letter = { 'u', 'n', 'i', 's', 'p' },
      shortcut = {
        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Apps',
          group = 'DiagnosticHint',
          action = 'Telescope app',
          key = 'a',
        },
        {
          desc = ' Project',
          group = 'Number',
          action = 'Telescope project',
          key = 'p',
        },
      },
    },
  })
  -- local utils = require('session_manager.utils')
  -- local session_name = utils.dir_to_session_filename(vim.loop.cwd())
  -- if session_name:exists() and not vim.g.neovide then
  --   vim.api.nvim_clear_autocmds({ event = 'UIEnter', group = 'Dashboard' })
  -- end
end

function config.session_manager()
  local sm = require('session_manager')
  local autoload_mode = require('session_manager.config').AutoloadMode
  sm.setup({
    sessions_dir = vim.env.HOME .. '/.cache/nvim/session',
    path_replacer = '__', -- The character to which the path separator will be replaced for session files.
    colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
    autoload_mode = vim.g.neovide and autoload_mode.Disabled or autoload_mode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_dirs = {
      '~',
    },
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
      'gitcommit',
      'dashboard',
      'NvimTree',
    },
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
  })
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      modified_icon = '✥',
      --buffer_close_icon = '',
      always_show_bufferline = false,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = true, -- use a "true" to enable the default, or set your own character
        },
      },
    },
  })
end

function config.nvim_tree()
  require('nvim-tree').setup({
    -- root_dirs = { '.', '~' },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    on_attach = require('modules.ui.nvim_tree').on_attach,
    -- update_focused_file = { enable = true, update_root = true },
    view = {
      width = 30,
      side = 'left',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      hide_root_folder = false,
    },
    renderer = {
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = '└',
          edge = '│',
          item = '│',
          none = ' ',
        },
      },
      icons = {
        glyphs = {
          default = '',
          symlink = '',
          folder = {
            arrow_closed = '',
            arrow_open = '',
            default = '',
            empty = '',
            empty_open = '',
            open = '',
            symlink = '',
            symlink_open = '',
          },
          git = {
            deleted = '',
            ignored = '',
            renamed = '',
            staged = '',
            unmerged = '',
            unstaged = '',
            untracked = 'ﲉ',
          },
        },
      },
    },
  })
end

function config.gitsigns()
  require('gitsigns').setup({
    signs = {
      add = {
        hl = 'GitSignsAdd',
        text = '▋',
        numhl = 'GitSignsAddNr',
        linehl = 'GitSignsAddLn',
      },
      change = {
        hl = 'GitSignsChange',
        text = '▋',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
      delete = {
        hl = 'GitSignsDelete',
        text = '▋',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      topdelete = {
        hl = 'GitSignsDelete',
        text = '▔',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn',
      },
      changedelete = {
        hl = 'GitSignsChange',
        text = '▎',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
    },
    keymaps = {
      noremap = true,
      buffer = true,
      -- Text objects
      [nmorqw('o rh', 'o ih')] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      [nmorqw('x rh', 'o ih')] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
  })
end

function config.wilder()
  local wilder = require('wilder')
  wilder.setup({
    modes = { ':', '/', '?' },
  })
  -- Disable Python remote plugin
  wilder.set_option('use_python_remote_plugin', 0)

  wilder.set_option('pipeline', {
    wilder.branch(
      wilder.cmdline_pipeline({
        fuzzy = 1,
        fuzzy_filter = wilder.lua_fzy_filter(),
      }),
      wilder.vim_search_pipeline()
    ),
  })
  local gradient = {
    '#f4468f',
    '#fd4a85',
    '#ff507a',
    '#ff566f',
    '#ff5e63',
    '#ff6658',
    '#ff704e',
    '#ff7a45',
    '#ff843d',
    '#ff9036',
    '#f89b31',
    '#efa72f',
    '#e6b32e',
    '#dcbe30',
    '#d2c934',
    '#c8d43a',
    '#bfde43',
    '#b6e84e',
    '#aff05b',
  }

  for i, fg in ipairs(gradient) do
    gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
  end

  wilder.set_option(
    'renderer',
    wilder.renderer_mux({
      [':'] = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
        border = 'rounded',
        max_height = '40%', -- max height of the palette
        min_height = 0, -- set to the same as 'max_height' for a fixed height window
        prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
        reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        highlights = {
          gradient = gradient, -- must be set
          -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
        },
        highlighter = wilder.highlighter_with_gradient({
          wilder.lua_fzy_highlighter(),
        }),
      })),
      ['/'] = wilder.wildmenu_renderer({
        highlights = {
          gradient = gradient, -- must be set
          -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
        },
        highlighter = wilder.highlighter_with_gradient({
          wilder.lua_fzy_highlighter(),
        }),
      }),
    })
  )
end

return config
