local api = vim.api
local my_group = vim.api.nvim_create_augroup('GlepnirGroup', {})

-- a yank highlight
vim.cmd('highlight YankHighlight guifg=#81c784 guibg=#384251')

api.nvim_create_autocmd('TextYankPost', {
  group = my_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 350 })
  end,
})

api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'InsertLeave' }, {
  group = my_group,
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'dashboard' and not vim.opt_local.cursorline:get() then
      vim.opt_local.cursorline = true
    end
  end,
})

api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'InsertEnter' }, {
  group = my_group,
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'dashboard' and vim.opt_local.cursorline:get() then
      vim.opt_local.cursorline = false
    end
  end,
})
