return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  -- run test nearest the cursor
  vim.keymap.set('n', '<leader>t', ':TestNearest<CR>'),
  -- run all tests in file
  vim.keymap.set('n', '<leader>T', ':TestFile<CR>'),
  -- run the while test suite
  vim.keymap.set('n', '<leader>a', ':TestSuite<CR>'),
  vim.keymap.set('n', '<leader>l', ':TestLast<CR>'),
  vim.keymap.set('n', '<leader>g', ':TestVisit<CR>'),

  vim.cmd("let test#strategy = 'vimux'")
}
