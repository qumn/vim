local config = {}

local ensure_installed = {
  'bash',
  'c',
  'javascript',
  'json',
  'lua',
  'python',
  'typescript',
  'tsx',
  'css',
  'rust',
  'java',
  'yaml',
}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = ensure_installed,
    ignore_install = { 'phpdoc' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "latex" },
    },
    indent = { enable = true, disable = { "yaml", "python" } },
    autotag = { enable = false },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = 1000, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
          ['il'] = '@loop.inner',
          ['al'] = '@loop.outer',
        },
      },
    },
  })
end

function config.ufo()
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end

  require('ufo').setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds = { 'imports' },
    fold_virt_text_handler = handler,
    preview = {
      win_config = {
        border = { '', '─', '', '', '', '─', '', '' },
        winhighlight = 'Normal:Folded',
        winblend = 0,
      },
      mappings = {
        scrollU = '<C-u>',
        scrollD = '<C-d>',
      },
    },
  })
end

function config.symbols_outline()
  local opts = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 18,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = { '', '' },
    wrap = false,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { '<Esc>', 'q' },
      goto_location = '<Cr>',
      focus_location = 'o',
      hover_symbol = '<C-space>',
      toggle_preview = 'K',
      rename_symbol = 'r',
      code_actions = 'a',
      fold = 'h',
      unfold = 'l',
      fold_all = 'M',
      unfold_all = 'R',
      fold_reset = 'E',
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
      File = { icon = '', hl = 'TSURI' },
      Module = { icon = '', hl = 'TSNamespace' },
      Namespace = { icon = '', hl = 'TSNamespace' },
      Package = { icon = '', hl = 'TSNamespace' },
      Class = { icon = '𝓒', hl = 'TSType' },
      Method = { icon = 'ƒ', hl = 'TSMethod' },
      Property = { icon = '', hl = 'TSMethod' },
      Field = { icon = '', hl = 'TSField' },
      Constructor = { icon = '', hl = 'TSConstructor' },
      Enum = { icon = 'ℰ', hl = 'TSType' },
      Interface = { icon = 'ﰮ', hl = 'TSType' },
      Function = { icon = '', hl = 'TSFunction' },
      Variable = { icon = '', hl = 'TSConstant' },
      Constant = { icon = '', hl = 'TSConstant' },
      String = { icon = '𝓐', hl = 'TSString' },
      Number = { icon = '#', hl = 'TSNumber' },
      Boolean = { icon = '⊨', hl = 'TSBoolean' },
      Array = { icon = '', hl = 'TSConstant' },
      Object = { icon = '⦿', hl = 'TSType' },
      Key = { icon = '🔐', hl = 'TSType' },
      Null = { icon = 'NULL', hl = 'TSType' },
      EnumMember = { icon = '', hl = 'TSField' },
      Struct = { icon = '𝓢', hl = 'TSType' },
      Event = { icon = '🗲', hl = 'TSType' },
      Operator = { icon = '+', hl = 'TSOperator' },
      TypeParameter = { icon = '𝙏', hl = 'TSParameter' },
    },
  }
  require('symbols-outline').setup(opts)
end

function config.doge()
  vim.g.doge_mapping = '<Leader>dG'
end

return config
