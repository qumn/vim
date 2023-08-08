local api = vim.api
local lspconfig = require('lspconfig')

-- local saga = require('lspsaga')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd('edit ' .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')

local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = 'ﴞ ',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    source = true,
  },
})

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    api.nvim_create_autocmd('BufWritePre', {
      pattern = client.config.filetypes,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          async = true,
        })
      end,
    })
  end
end

lspconfig.gopls.setup({
  on_attach = on_attach,
  cmd = { 'gopls', '--remote=auto' },
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      hint = {
        enable = true,
        -- virtualText = true,
      },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'packer_plugins', 'hs' },
      },
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = vim.list_extend({ [vim.fn.expand('$VIMRUNTIME/lua')] = true }, {}),
      },
    },
  },
})

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
})

local rt = require('rust-tools')
rt.setup({
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  fileTypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
})

-- lspconfig.unocss.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = lspconfig.util.root_pattern('unocss.config.js', 'unocss.config.ts', 'uno.config.ts', 'uno.config.js'),
-- })

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'sh', 'bash', 'zsh' },
})
lspconfig.eslint.setup({
  on_attach = function(_client, bufnr)
    -- saga.init_lsp_saga()
    on_attach()
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
  end,
  capabilities = capabilities,
  -- filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  settings = {
    autoFixOnSave = true
  },
})

local servers = {
  'dockerls',
  'pyright',
  -- 'denols',
  'jsonls',
  'volar',
  'tailwindcss',
  'texlab',
  -- 'dartls',
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
