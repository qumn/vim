local M = { init = false }

-- 
-- local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" };
local status = ''
local icon = ' '
local setup = function()
  local api = require('copilot.api')
  -- if not api then
  --   status = 'Copilot: not Enable'
  --   return
  -- end
  api.register_status_notification_handler(function(data)
    -- customize your message however you want
    data.status = string.lower(data.status)
    status = data.status
    if data.status == 'error' then
      icon = ' '
      return
    elseif data.status == 'normal' then
      icon = ' '
    elseif data.status == 'inprogress' then
      icon = ' '
    elseif data.status == 'warning' then
      icon = ' '
    end
  end)
end

M.get_status = function()
  if not M.init then
    setup()
    M.init = true
  end
  return status
end
M.get_icon = function()
  if not M.init then
    setup()
    M.init = true
  end
  return icon
end
return M
