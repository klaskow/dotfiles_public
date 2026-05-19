return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    vim.g.illuminate_lsp = false
    require('illuminate').configure({ providers = { 'treesitter', 'regex' } })
  end,
}
