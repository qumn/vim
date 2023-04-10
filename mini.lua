local lazypath = vim.fn.stdpath("data") .. "/mini/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "williamboman/mason.nvim" },
	{ "neovim/nvim-lspconfig" },
  {'nvim-treesitter/nvim-treesitter'},
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
  }
})


require("mason").setup()
require("nvim-treesitter.configs").setup({
})

local api = vim.api
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		api.nvim_create_autocmd("BufWritePre", {
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

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = { "vim", "packer_plugins", "hs" },
			},
			runtime = { version = "LuaJIT" },
			workspace = {
				library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
			},
		},
	},
})
