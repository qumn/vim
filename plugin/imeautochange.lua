-- a simple plugin for change ime when you enter insert mode
-- it can store the ime when you leave insert mode
-- then change it back when you enter insert mode
-- the plugin dependen on macism command

-- is has macism command
if vim.fn.executable('macism') ~= 1 then
  print("can't find macism command")
end

local ctx = {}
local uv = vim.loop
vim.g.US_IME = 'com.apple.keylayout.US'
vim.g.CHINESE_IME = 'com.sogou.inputmethod.sogou.pinyin'

local function safe_close(handle)
  if not uv.is_closing(handle) then
    uv.close(handle)
  end
end

local function onread(err, data)
  if err then
    error(err)
  end
  if data then
    vim.g.last_ime = vim.split(data, '\n')[1]
  end
end

-- same current ime on vim.g.last_ime
local function save_current_ime()
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  ctx.handle = vim.loop.spawn('macism', {
    stdio = { nil, stdout, stderr },
  }, function()
    stdout:read_stop()
    stderr:read_stop()
    safe_close(ctx.handle)
    safe_close(stdout)
    safe_close(stderr)
  end)

  vim.loop.read_start(stdout, onread)
  vim.loop.read_start(stderr, onread)
end

local function ime_change(target_ime)
  target_ime = target_ime or vim.g.US_IME
  -- save current ime
  ctx.handle = vim.loop.spawn('macism', { args = { target_ime } }, function()
    safe_close(ctx.handle)
  end)
end

vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  pattern = '*',
  callback = function()
    save_current_ime()
    ime_change(vim.g.US_IME)
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  pattern = '*',
  callback = function()
    ime_change(vim.g.last_ime)
  end,
})

return ctx
