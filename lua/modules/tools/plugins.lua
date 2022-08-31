-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/popup.nvim', opt = true },
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
    { 'nvim-telescope/telescope-project.nvim', opt = true},
  },
})

plugin({
  "mfussenegger/nvim-treehopper"
})

plugin({
  "phaazon/hop.nvim",
  config = function()
    require('hop').setup()
  end
})
plugin({
  "ahmedkhalf/project.nvim",
  config = conf.project
})
