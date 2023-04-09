if not vim.g.is_norman then
  return
end

vim.cmd([[
  " === norman keyboard layout
  nnoremap y h
  nnoremap n j
  nnoremap i k
  nnoremap o l

  vnoremap y h
  vnoremap n j
  vnoremap i k
  vnoremap o l

  " a workaround for the fact that `i` are used up in visual mode
  vnoremap " i"
  vnoremap ( i)
  vnoremap [ i]
  vnoremap { i}

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
  noremap <c-l> <c-o>


  " sunmap y
  " sunmap n
  " sunmap i
  " sunmap o
  " sunmap Y
  " sunmap O
  " sunmap N
  " sunmap r
  " sunmap R
  " sunmap l
  " sunmap L
  " sunmap j
  " sunmap h
  " sunmap H
  " sunmap k
  " sunmap K

  " ounmap r
  " ounmap R
  " xunmap r
  " xunmap R
]])
