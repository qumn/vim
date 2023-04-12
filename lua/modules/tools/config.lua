-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

function config.telescope()
  local actions = require('telescope.actions')
  require('telescope').setup({
    defaults = {
      -- layout_config = {
      --   horizontal = { prompt_position = 'top', results_width = 0.6 },
      --   vertical = { mirror = false },
      -- },
      theme = 'ivy',
      sorting_strategy = 'ascending',
      layout_strategy = 'bottom_pane',
      layout_config = {
        height = 0.5,
      },
      border = true,
      borderchars = {
        prompt = { '─', ' ', ' ', ' ', '─', '─', ' ', ' ' },
        results = { ' ' },
        preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      mappings = {
        i = {
          ['<C-s>'] = actions.select_horizontal,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-i>'] = actions.move_selection_previous,
        },
        n = {
          ['n'] = actions.move_selection_next,
          ['i'] = actions.move_selection_previous,
          ['Y'] = actions.move_to_top,
          ['M'] = actions.move_to_middle,
          ['O'] = actions.move_to_bottom,
          ['<C-s>'] = actions.select_horizontal,
        },
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('file_browser')
  --require('telescope').load_extension('projects')
end

function config.project()
  require('project_nvim').setup({
    active = true,
    on_config_done = nil,
    manual_mode = false,
    detection_methods = { 'pattern' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
    show_hidden = false,
    silent_chdir = true,
    ignore_lsp = {},
  })
end

function config.tmux()
  require('tmux').setup({
    copy_sync = {
      enable = false, -- 启动这个选项会使':'变得非常慢
    },
    navigation = {
      enable_default_keybindings = false,
    },
    resize = {
      enable_default_keybindings = true,
    },
  })
end

function config.diffview()
  local actions = require('diffview.actions')

  require('diffview').setup({
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
      folder_closed = '',
      folder_open = '',
    },
    signs = {
      fold_closed = '',
      fold_open = '',
    },
    file_panel = {
      listing_style = 'tree', -- One of 'list' or 'tree'
      tree_options = { -- Only applies when listing_style is 'tree'
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
      },
      win_config = { -- See ':h diffview-config-win_config'
        position = 'bottom',
        height = 16,
      },
    },
    file_history_panel = {
      log_options = {
        max_count = 256, -- Limit the number of commits
        follow = false, -- Follow renames (only for single file)
        all = false, -- Include all refs under 'refs/' including HEAD
        merges = false, -- List only merge commits
        no_merges = false, -- List no merge commits
        reverse = false, -- List commits in reverse order
      },
      win_config = { -- See ':h diffview-config-win_config'
        position = 'bottom',
        height = 16,
      },
    },
    commit_log_panel = {
      win_config = {}, -- See ':h diffview-config-win_config'
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
    keymaps = {
      disable_defaults = false, -- Disable the default keymaps
      view = {
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        ['<tab>'] = actions.select_next_entry, -- Open the diff for the next file
        ['<s-tab>'] = actions.select_prev_entry, -- Open the diff for the previous file
        ['gf'] = actions.goto_file, -- Open the file in a new split in previous tabpage
        ['<C-w><C-f>'] = actions.goto_file_split, -- Open the file in a new split
        ['<C-w>gf'] = actions.goto_file_tab, -- Open the file in a new tabpage
        ['<leader>e'] = actions.focus_files, -- Bring focus to the files panel
        ['<leader>b'] = actions.toggle_files, -- Toggle the files panel.
      },
      file_panel = {
        ['j'] = actions.next_entry, -- Bring the cursor to the next file entry
        ['<down>'] = actions.next_entry,
        ['k'] = actions.prev_entry, -- Bring the cursor to the previous file entry.
        ['<up>'] = actions.prev_entry,
        ['<cr>'] = actions.select_entry, -- Open the diff for the selected entry.
        ['o'] = actions.select_entry,
        ['<2-LeftMouse>'] = actions.select_entry,
        ['-'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
        ['S'] = actions.stage_all, -- Stage all entries.
        ['U'] = actions.unstage_all, -- Unstage all entries.
        ['X'] = actions.restore_entry, -- Restore entry to the state on the left side.
        ['R'] = actions.refresh_files, -- Update stats and entries in the file list.
        ['L'] = actions.open_commit_log, -- Open the commit log panel.
        ['<c-b>'] = actions.scroll_view(-0.25), -- Scroll the view up
        ['<c-f>'] = actions.scroll_view(0.25), -- Scroll the view down
        ['<tab>'] = actions.select_next_entry,
        ['<s-tab>'] = actions.select_prev_entry,
        ['gf'] = actions.goto_file,
        ['<C-w><C-f>'] = actions.goto_file_split,
        ['<C-w>gf'] = actions.goto_file_tab,
        ['i'] = actions.listing_style, -- Toggle between 'list' and 'tree' views
        ['f'] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
        ['<leader>b'] = actions.focus_files,
        ['<leader>e'] = actions.toggle_files,
      },
      file_history_panel = {
        ['g!'] = actions.options, -- Open the option panel
        ['<C-A-d>'] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
        ['y'] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
        ['L'] = actions.open_commit_log,
        ['zR'] = actions.open_all_folds,
        ['zM'] = actions.close_all_folds,
        ['j'] = actions.next_entry,
        ['<down>'] = actions.next_entry,
        ['k'] = actions.prev_entry,
        ['<up>'] = actions.prev_entry,
        ['<cr>'] = actions.select_entry,
        ['o'] = actions.select_entry,
        ['<2-LeftMouse>'] = actions.select_entry,
        ['<c-b>'] = actions.scroll_view(-0.25),
        ['<c-f>'] = actions.scroll_view(0.25),
        ['<tab>'] = actions.select_next_entry,
        ['<s-tab>'] = actions.select_prev_entry,
        ['gf'] = actions.goto_file,
        ['<C-w><C-f>'] = actions.goto_file_split,
        ['<C-w>gf'] = actions.goto_file_tab,
        ['<leader>e'] = actions.focus_files,
        ['<leader>b'] = actions.toggle_files,
      },
      option_panel = {
        ['<tab>'] = actions.select_entry,
        ['q'] = actions.close,
      },
    },
  })
end

function config.which_key()
  local wk = require('which-key')
  wk.setup({
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
  })
  local map = require('keymap.map')
  wk.register(map.nlmappings, map.nlopts)
  wk.register(map.nmappings, map.nopts)
end

function config.table_modle()
  vim.cmd([[
    function! s:isAtStartOfLine(mapping)
      let text_before_cursor = getline('.')[0 : col('.')-1]
      let mapping_pattern = '\V' . escape(a:mapping, '\')
      let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
      return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
    endfunction

    inoreabbrev <expr> <bar><bar>
              \ <SID>isAtStartOfLine('\|\|') ?
              \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
    inoreabbrev <expr> __
              \ <SID>isAtStartOfLine('__') ?
              \ '<c-o>:silent! TableModeDisable<cr>' : '__'
  ]])
end

return config
