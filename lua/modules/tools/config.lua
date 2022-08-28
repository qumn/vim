-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

function config.telescope()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd([[packadd plenary.nvim]])
    vim.cmd([[packadd popup.nvim]])
    vim.cmd([[packadd telescope-fzy-native.nvim]])
    vim.cmd([[packadd telescope-file-browser.nvim]])
  end
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
end

function config.project()
    require("project_nvim").setup {
      active = true,
      on_config_done = nil,
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      show_hidden = false,
      silent_chdir = true,
      ignore_lsp = {},
    }
end

return config
