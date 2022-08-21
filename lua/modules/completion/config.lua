-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

-- config server in this function
function config.nvim_lsp() 
  require('modules.completion.lspconfig')
end

function config.nvim_cmp()
  local cmp = require('cmp')
  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local lspkind_icons = {
          Text = '',
          Method = ' ',
          Function = '',
          Constructor = ' ',
          Field = ' ',
          Variable = ' ',
          Class = '',
          Interface = '',
          Module = '',
          Property = '',
          Unit = ' ',
          Value = '',
          Enum = ' ',
          Keyword = 'ﱃ',
          Snippet = ' ',
          Color = ' ',
          File = ' ',
          Reference = 'Ꮢ',
          Folder = ' ',
          EnumMember = ' ',
          Constant = ' ',
          Struct = ' ',
          Event = '',
          Operator = '',
          TypeParameter = ' ',
        }
        local meta_type = vim_item.kind
        -- load lspkind icons
        vim_item.kind = lspkind_icons[vim_item.kind] .. ''

        vim_item.menu = ({
          buffer = ' Buffer',
          nvim_lsp = meta_type,
          path = ' Path',
          luasnip = ' LuaSnip',
        })[entry.source.name]

        return vim_item
      end,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ['<C-e>'] = cmp.config.disable,
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  })

end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.mason()
  require("mason").setup()
end

function config.lspsaga()
    local keymap = vim.keymap.set
    local saga = require('lspsaga')

    saga.init_lsp_saga()

    -- Lsp finder find the symbol definition implmement reference
    -- when you use action in finder like open vsplit then your can
    -- use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

    -- Code action
    keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
    keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

    -- Rename
    keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

    -- Definition preview
    keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

    -- Show line diagnostics
    keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

    -- Show cursor diagnostic
    keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnsotic jump
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })

    -- Only jump to error
    keymap("n", "[E", function()
      require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    keymap("n", "]E", function()
      require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    -- Outline
    keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

    -- Hover Doc
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    -- Signature help
    keymap("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { silent = true })

    local action = require("lspsaga.action")
    -- scroll in hover doc or  definition preview window
    vim.keymap.set("n", "<C-f>", function()
      action.smart_scroll_with_saga(1)
    end, { silent = true })
    -- scroll in hover doc or  definition preview window
    vim.keymap.set("n", "<C-b>", function()
      action.smart_scroll_with_saga(-1)
    end, { silent = true })
end

return config
