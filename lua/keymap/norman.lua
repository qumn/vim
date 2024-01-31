if not vim.g.is_norman then
  return
end

vim.cmd([[
  " === norman keyboard layout
  nnoremap y h
  " nnoremap n j
  " nnoremap i k
  nnoremap o l

  vnoremap y h
  vnoremap n j
  vnoremap i k
  vnoremap o l

  " a workaround for the fact that `i` are used up in visual mode
  " vnoremap " i"
  vnoremap ( i)
  vnoremap [ i]
  vnoremap { i}
  onoremap o l
  xnoremap o l
  onoremap y h
  xnoremap y h

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
  nnoremap <c-l> <c-o>
  nnoremap <c-r> <c-i>
  nnoremap <c-u> <c-r>

  " map for jump between windows
  nnoremap <C-w>y <C-w>h
  nnoremap <C-w>n <C-w>j
  nnoremap <C-w>i <C-w>k
  nnoremap <C-w>o <C-w>l

  xnoremap p pgvy

  " clear all mappings in select mode
  smapclear
  " tmapclear

  " tnoremap <silent><leader>; <Cmd>exe v:count1 . "ToggleTerm"<CR>
  " tnoremap <silent><C-i> <C-\><C-n><C-w>k

  autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
]])

if vim.g.neovide then
  vim.cmd([[
    nmap <D-c> "+y
    vmap <D-c> "+y
    nmap <D-v> "+p
    inoremap <D-v> <c-r>+
    cnoremap <D-v> <c-r>+
    " use <c-r> to insert original character without triggering things like auto-pairs
    inoremap <D-r> <c-v>
  ]])
end

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'ni', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-y>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-n>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-i>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-o>', [[<Cmd>wincmd l<CR>]], opts)
  -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

vim.keymap.set('n', 'n', function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. 'j'
  else
    return 'gj'
  end
end, { noremap = true, expr = true })

vim.keymap.set('n', 'i', function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. 'k'
  else
    return 'gk'
  end
end, { noremap = true, expr = true })
