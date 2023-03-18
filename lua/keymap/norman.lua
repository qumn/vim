if not vim.g.is_norman then
  return;
end

vim.cmd [[
  " === norman keyboard layout
  noremap y h
  noremap n j
  noremap i k
  noremap o l
  noremap Y ^
  noremap O $
  noremap N J
  " noremap I K

  " map r <Nop>
  noremap r i
  noremap R I
  noremap l o
  noremap L O

  noremap j y
  noremap h n
  noremap H N
  noremap k r
  noremap K R


  sunmap y
  sunmap n
  sunmap i
  sunmap o
  sunmap Y
  sunmap O
  sunmap N
  sunmap r
  sunmap R
  sunmap l
  sunmap L
  sunmap j
  sunmap h
  sunmap H
  sunmap k
  sunmap K

  ounmap r
  ounmap R
  xunmap r
  xunmap R
]]
