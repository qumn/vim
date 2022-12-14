local map = {}
local key = require('core.keymap')
local vmap = key.vmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

function map.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
  if modified then
    vim.ui.input({
      prompt = 'You have unsaved changes. Quit anyway? (y/n) ',
    }, function(input)
      if input == 'y' then
        vim.cmd('q!')
      end
    end)
  else
    vim.cmd('q!')
  end
end

map.nlmappings = {
  [';'] = { cmd('Dashboard'), 'Dashboard' },
  ['/'] = { '<Plug>(comment_toggle_linewise_current)', 'Comment toggle current line' },
  c = { cmd('bd'), 'Close Buffer' },
  h = { cmd('nohlsearch'), 'No Highlight' },
  w = { cmd('w!'), 'Save Buffer' },
  e = { cmd('NvimTreeFindFileToggle'), 'NvimTree Toggle' },
  n = { cmd('DashboardNewFile'), 'Dashboard New File' },
  o = { cmd('LSoutlineToggle'), 'LSoutlineToggle' }, -- outline use `o` to jump
  q = { map.smart_quit, 'Quit' },
  b = {
    name = 'Buffers',
    j = { '<cmd>BufferLinePick<cr>', 'Jump' },
    f = { '<cmd>Telescope buffers<cr>', 'Find' },
    p = { '<cmd>BufferLineCyclePrev<cr>', 'Previous' },
    n = { '<cmd>BufferLineCycleNext<cr>', 'Next' },
    -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
    e = {
      '<cmd>BufferLinePickClose<cr>',
      'Pick which buffer to close',
    },
    h = { '<cmd>BufferLineCloseLeft<cr>', 'Close all to the left' },
    l = {
      '<cmd>BufferLineCloseRight<cr>',
      'Close all to the right',
    },
    D = {
      '<cmd>BufferLineSortByDirectory<cr>',
      'Sort by directory',
    },
    L = {
      '<cmd>BufferLineSortByExtension<cr>',
      'Sort by language',
    },
  },
  p = {
    name = 'Packer',
    u = { cmd('PackerUpdate'), 'Updater' },
    i = { cmd('PackerInstall'), 'Install' },
    c = { cmd('PackerCompile'), 'Compile' },
    s = { cmd('PackerSync'), 'Sync' },
    S = { cmd('PackerStatus'), 'Status' },
  },
  g = {
    name = 'Git',
    s = { cmd('lua require"gitsigns".stage_hunk()'), 'Stage Hunk' },
    u = { cmd('lua require"gitsigns".undo_stage_hunk()'), 'Undo Stage Hunk' },
    r = { cmd('lua require"gitsigns".reset_hunk()'), 'Reset Hunk' },
    R = { cmd('lua require"gitsigns".reset_buffer()'), 'Reset Buffer' },
    p = { cmd('lua require"gitsigns".preview_hunk()'), 'Preview Hunk' },
    l = { cmd('lua require"gitsigns".blame_line()'), 'Blame Line' },
    o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    g = { cmd('Lspsaga open_floaterm lazygit'), 'lazygit' },
  },
  l = {
    name = 'Lsp',
    a = { cmd('Lspsaga code_action'), 'code action' },
    d = { cmd('Lspsaga show_line_diagnostics'), 'Show Line Diagnostics' },
    e = { cmd('Lspsaga rename'), 'Lsp Rename' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    I = { '<cmd>Mason<cr>', 'Mason Info' },
    f = { cmd("lua require'keymap.format'.format()"), 'Format' },
    -- d = { cmd('Lspsaga show_cursor_diagnostics'), 'Show Cursor Diagnostics' },
  },
  d = {
    name = 'Diffview',
    d = { cmd('DiffviewFileHistory %'), 'Current File' },
    a = { cmd('DiffviewFileHistory'), 'All File' }, -- diffview all file
    o = { cmd('DiffviewOpen'), 'Open' },
    c = { cmd('DiffviewClose'), 'Close' },
    g = { cmd('DogeGenerate'), 'Generate Doc' },
  },

  s = {
    name = 'Session and Telescope',
    -- TODO: add a clean session keymap
    d = { cmd('SessionSave'), 'Save' },
    l = { cmd('SessionLoad'), 'Load' },
    h = { cmd('Telescope help_tags theme=get_ivy'), 'Help Tags' },
    k = { cmd('Telescope keymaps theme=get_ivy'), 'Keymaps' },
    b = { cmd('Telescope buffers theme=get_ivy'), 'Search Buffer' },
    a = { cmd('Telescope live_grep theme=get_ivy'), 'Live Grep' },
    f = { cmd('Telescope find_files theme=get_ivy'), 'Find Files' },
    o = { cmd('Telescope oldfiles theme=get_ivy'), 'Oldfile' },
    s = { cmd('Telescope lsp_document_symbols theme=get_ivy'), 'Lsp Document Symbols' },
    S = { cmd('Telescope lsp_workspace_symbols theme=get_ivy'), 'Lsp Workspace Symbols' },
    c = { cmd('Telescope git_commits theme=get_ivy'), '' },
    p = { cmd('Telescope projects theme=get_ivy'), '' },
  },
  t = {
    name = 'Translate',
    w = { cmd('TranslateW'), 'Translate' },
  },
}

map.nlopts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

map.nmappings = {
  [']'] = {
    name = 'Next',
    g = {
      cmd('lua require"gitsigns".next_hunk()'),
      'Git Change',
    },
    e = {
      cmd('Lspsaga diagnostic_jump_next'),
      'Warning or Error',
    },
    E = {
      cmd('lua require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })'),
      'Only Error',
    },
  },
  ['['] = {
    name = 'Prev',
    g = { cmd('lua require"gitsigns".prev_hunk()'), 'Git Change' },
    e = {
      cmd('Lspsaga diagnostic_jump_prev'),
      'Warning or Error',
    },
    E = { cmd('require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })'), 'Only Error' },
  },
  -- hop
  s = {
    name = 'Hop and Telescope',
    l = { cmd('HopWordAC'), 'HopWord after' },
    h = { cmd('HopWordBC'), 'HopWord before' },
    j = { cmd('HopLineStartAC'), 'HopLine after' },
    k = { cmd('HopLineStartBC'), 'HopLine before' },
    m = { cmd('lua require("tsht").move()'), 'Treehop Move' },
    v = { cmd('lua require("tsht").nodes()'), 'Treehop select' },
    b = { cmd('Telescope buffers theme=get_ivy'), 'Search Buffer' },
    a = { cmd('Telescope live_grep theme=get_ivy'), 'Live Grep' },
    f = { cmd('Telescope find_files theme=get_ivy'), 'Find Files' },
    o = { cmd('Telescope oldfiles theme=get_ivy'), 'Oldfile' },
    s = { cmd('Telescope lsp_document_symbols theme=get_ivy'), 'Lsp Document Symbols' },
    S = { cmd('Telescope lsp_workspace_symbols theme=get_ivy'), 'Lsp Workspace Symbols' },
    c = { cmd('Telescope git_commits theme=get_ivy'), 'Git Commits' },
    p = { cmd('Telescope projects theme=get_ivy'), 'Projects' },
  },
  g = {
    h = { cmd('Lspsaga lsp_finder'), 'Lsp Finder' },
    r = { cmd('Lspsaga rename'), 'Lsp Rename' },
    p = { cmd('Lspsaga preview_definition'), 'Lsp Preview Definition' },
    d = { cmd('lua vim.lsp.buf.definition()'), 'Goto Definetion' },
  },
}

map.nopts = {
  mode = 'n', -- NORMAL mode
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

vmap({
  { '<leader>ca', cmd('<C-U>Lspsaga range_code_action'), opts(noremap, silent) },
  { '=', cmd('lua vim.lsp.buf.range_formatting()'), opts(noremap, silent) },
})

return map
