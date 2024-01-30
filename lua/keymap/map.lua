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
        vim.cmd('quitall!')
      end
    end)
  else
    vim.cmd('quitall!')
  end
end

local command = {
  dart = 'FlutterRun',
}

map.nlmappings = {
  -- [";"] = { cmd('ToggleTerm'), 'Terminal' },
  ["'"] = { cmd('Dashboard'), 'Dashboard' },
  ['/'] = { '<Plug>(comment_toggle_linewise_current)', 'Comment toggle current line' },
  c = { cmd('bd'), 'Close Buffer' },
  h = { cmd('nohlsearch'), 'No Highlight' },
  w = { cmd('w!'), 'Save Buffer' },
  e = { cmd('NvimTreeFindFile'), 'NvimTree Toggle' },
  n = {
    i = { cmd('Telescope neorg insert_link'), 'Inset linkable' },
    f = { cmd('Telescope neorg find_linkable'), 'Inset linkable' },
  },
  r = {
    function()
      local filetype = vim.bo.filetype
      if command[filetype] then
        vim.cmd(command[filetype])
      else
        print('No run command for ' .. filetype)
      end
    end,
    'run',
  },
  o = {
    function()
      if vim.bo.filetype == 'dart' then
        vim.cmd('FlutterOutlineToggle')
      else
        vim.cmd('SymbolsOutline')
      end
    end,
    'LSoutlineToggle',
  }, -- outline use `o` to jump
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
    o = { cmd('Telescope git_status'), 'Open changed file' },
    b = { cmd('Telescope git_branches'), 'Checkout branch' },
    c = { cmd('Telescope git_commits'), 'Checkout commit' },
    g = { cmd('Lspsaga open_floaterm lazygit'), 'lazygit' },
  },
  l = {
    name = 'Lsp',
    a = { cmd('Lspsaga code_action'), 'code action' },
    d = { cmd('Lspsaga show_line_diagnostics'), 'Show Line Diagnostics' },
    e = { cmd('lua vim.lsp.buf.rename()'), 'Lsp Rename' },
    i = { cmd('LspInfo'), 'Info' },
    I = { cmd('Mason'), 'Mason Info' },
    f = { cmd('Format'), 'Format' },
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
    h = { cmd('Telescope help_tags'), 'Help Tags' },
    k = { cmd('Telescope keymaps'), 'Keymaps' },
    b = { cmd('Telescope buffers'), 'Search Buffer' },
    a = { cmd('Telescope live_grep'), 'Live Grep' },
    f = { cmd('Telescope find_files'), 'Find Files' },
    e = { cmd('Telescope oldfiles'), 'Oldfile' },
    s = { cmd('Telescope lsp_document_symbols'), 'Lsp Document Symbols' },
    S = { cmd('Telescope lsp_dynamic_workspace_symbols'), 'Lsp Workspace Symbols' },
    c = { cmd('Telescope git_commits'), '' },
    p = { cmd('Telescope project'), '' },
    m = { cmd('Telescope help_tags'), '' },
  },
  t = {
    name = 'Translate',
    w = { cmd('Translate'), 'Translate' },
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
    g = { cmd('lua require"gitsigns".next_hunk()'), 'Git Change' },
    e = { cmd('Lspsaga diagnostic_jump_next'), 'Warning or Error' },
    E = {
      function()
        require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      'Only Error',
    },
  },
  ['['] = {
    name = 'Prev',
    g = { cmd('lua require"gitsigns".prev_hunk()'), 'Git Change' },
    e = { cmd('Lspsaga diagnostic_jump_prev'), 'Warning or Error' },
    E = {
      -- cmd('lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })'),
      function()
        require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      'Only Error',
    },
  },
  -- hop
  s = {
    name = 'Hop and Telescope',
    [nmorqw('y', 'h')] = { cmd('HopWordBC'), 'HopWord before' },
    [nmorqw('n', 'j')] = { cmd('HopLineStartAC'), 'HopLine after' },
    [nmorqw('i', 'k')] = { cmd('HopLineStartBC'), 'HopLine before' },
    [nmorqw('o', 'l')] = { cmd('HopWordAC'), 'HopWord after' },
    v = { cmd('vsplit'), 'Split Vertically' },
    h = { cmd('split'), 'Split' },
    m = { cmd('lua require("tsht").move()'), 'Treehop Move' },
    [nmorqw('j', 'n')] = { cmd('lua require("tyht").nodes()'), 'Treehop select' },
    b = { cmd('Telescope buffers'), 'Search Buffer' },
    a = { cmd('Telescope live_grep'), 'Live Grep' },
    f = { cmd('Telescope find_files'), 'Find Files' },
    e = { cmd('Telescope oldfiles'), 'Oldfile' },
    s = { cmd('Telescope lsp_document_symbols'), 'Lsp Document Symbols' },
    S = { cmd('Telescope lsp_dynamic_workspace_symbols'), 'Lsp Workspace Symbols' },
    c = { cmd('Telescope git_commits'), 'Git Commits' },
    p = { cmd('Telescope project'), 'Projects' },
    t = { cmd('BufferLinePick'), 'BufferLinePick' },
  },
  g = {
    h = { cmd('Lspsaga finder'), 'Lsp Finder' },
    r = { cmd('Lspsaga rename'), 'Lsp Rename' },
    p = { cmd('Lspsaga peek_definition'), 'Lsp Preview Definition' },
    --s = { cmd('Lspsaga peek_type_definition'), 'Lsp Preview Definition' },
    s = { '<Plug>(leap-forward-to)', 'leap forward to' },
    S = { '<Plug>(leap-backward-to)', 'leap backward to' },
    d = { cmd('Lspsaga goto_definition'), 'Goto Definetion' },
    t = { cmd('Lspsaga peek_type_definition'), 'Show Line Diagnostics' },
    T = { cmd('Lspsaga goto_type_definition'), 'Show Line Diagnostics' },
  },
  ['<C-w>'] = {
    z = { cmd('WindowsMaximize'), 'Windows Maximize' },
    ['_'] = { cmd('WindowsMaximizeVertically'), 'Windows Maximize Vertically' },
    ['|'] = { cmd('WindowsMaximizeHorizontally'), 'Windows Maximize Horizontally' },
    ['='] = { cmd('WindowsEqualize'), 'Windows Equalize' },
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
