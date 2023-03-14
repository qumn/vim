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
    show_current_context = false,
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
  local home = os.getenv('HOME')
  local db = require('dashboard')
  db.session_directory = home .. '/.cache/nvim/session'
  -- db.custom_header = 'header'
  -- db.preview_command = 'cat | lolcat -F 0.3'
  -- db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
  -- db.preview_file_height = 12
  -- db.preview_file_width = 80
  db.custom_center = {
    {
      icon = '冷 ',
      desc = 'Open Recent Project                     ',
      shortcut = 'SPC s p',
      action = 'Telescope projects',
    },
    {
      icon = '  ',
      desc = 'Update Plugins                          ',
      shortcut = 'SPC p u',
      action = 'PackerUpdate',
    },
    {
      icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f',
    },
  }
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      modified_icon = '✥',
      buffer_close_icon = '',
      always_show_bufferline = false,
    },
  })
end

function config.nvim_tree()
  require('nvim-tree').setup({
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = { enable = true, update_cwd = true },
    view = {
      width = 30,
      side = 'left',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      hide_root_folder = false,
      mappings = {
        list = {
          { key = { 'l' }, action = 'edit' },
          { key = { 's' }, action = 'split' },
          { key = { 'v' }, action = 'vsplit' },
        },
      },
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
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd([[packadd plenary.nvim]])
  end
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

return config
