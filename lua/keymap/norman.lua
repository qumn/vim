if not vim.g.is_norman then
  return;
end

vim.cmd [[
  noremap n j
  noremap y h
  noremap i k
  noremap o l

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
  nnoremap k r
  nnoremap K R

]]
