-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- config server in this function
function config.nvim_lsp()
  require('modules.completion.lspconfig')
end

function config.nvim_cmp()
  local cmp = require('cmp')
  local types = require('cmp.types')
  local luasnip = require('luasnip')
  local copilot = require('copilot.suggestion')
  local pre = nmorqw('<C-i>', '<C-k>')

  cmp.setup({
    preselect = cmp.PreselectMode.Item,

    window = {
      completion = {
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        -- col_offset = -3,
        side_padding = 0,
      },
    },
    -- window = {
    --   completion = cmp.config.window.bordered(),
    --   documentation = cmp.config.window.bordered(),
    -- },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local kind = require('lspkind').cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          symbol_map = { Copilot = '' },
        })(entry, vim_item)

        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        kind.kind = ' ' .. (strings[1] or '') .. ' '
        kind.menu = '    (' .. (strings[2] or '') .. ')'

        return kind
      end,
    },
    -- You can set mappings if you want
    mapping = {
      ['<Down>'] = {
        i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
      },
      ['<Up>'] = {
        i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
      },
      [nmorqw('<C-n>', '<C-j>')] = cmp.mapping.select_next_item(),
      [pre] = cmp.mapping.select_prev_item(), --
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
      ['<C-h>'] = cmp.mapping.close(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
      }),
      ['<CR>'] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        elseif cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
        else
          fallback()
        end
      end),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif copilot.is_visible() then -- use <C-a> to accept
          copilot.accept()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'neorg' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
    experimental = { ghost_text = true }, -- show virtual text selected
  })
  -- in neovide cannot use noice, so use cmp-coroutine instead
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    -- history = true,
    enable_autosnippets = true,
    -- updateevents = 'TextChanged,TextChangedI',
    region_check_events = 'CursorHold,InsertLeave,InsertEnter',
    delete_check_events = 'TextChanged,InsertEnter',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.mason()
  require('mason').setup()
end

function config.lspsaga()
  local saga = require('lspsaga')
  saga.setup({
    symbol_in_winbar = {
      enable = false,
    },
    scroll_preview = {
      scroll_down = '<C-f>',
      scroll_up = '<C-b>',
    },
    finder = {
      keys = {
        shuttle = '[w',
        toggle_or_open = 'o',
        vsplit = 's',
        split = 'i',
        tabe = { 't', '<CR>' },
        tabnew = nmorqw('T', 'r'),
        quit = 'q',
        close = '<ESC>',
      },
    },
    outline = {
      win_position = 'right',
      win_with = '',
      win_width = 30,
      show_detail = true,
      auto_preview = true,
      auto_refresh = true,
      auto_close = true,
      custom_sort = nil,
      keys = {
        jump = { nmorqw('l', '<CR>') },
        expand_collapse = 'u',
        quit = 'q',
      },
    },
  })
end

function config.auto_pairs()
  require('nvim-autopairs').setup({})
  local status, cmp = pcall(require, 'cmp')
  if not status then
    vim.cmd([[packadd nvim-cmp]])
  end
  cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

function config.null_ls()
  local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
  if not null_ls_status_ok then
    return
  end

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    sources = {
      formatting.prettier.with({ extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' } }),
      formatting.black.with({ extra_args = { '--fast' } }),
      formatting.stylua,
      formatting.jq,
      formatting.rustfmt,
      formatting.beautysh,
      diagnostics.flake8,
    },
  })
end

function config.lsp_signature()
  local cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath('cache') .. '/lsp_signature.log', -- log dir when debug is on
    -- default is  ~/.cache/nvim/lsp_signature.log
    verbose = false, -- show debug line number

    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    floating_window_off_x = 1, -- adjust float windows x position.
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

    close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = '🐼 ', -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = 'String',
    hi_parameter = 'TSNote', -- TODO: change to better color -- how your parameter will be highlight
    handler_opts = {
      border = 'rounded', -- double, rounded, single, shadow, none
    },

    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = '<C-k>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
  }
  local lsp_signature = require('lsp_signature')

  lsp_signature.setup(cfg)
end

return config
