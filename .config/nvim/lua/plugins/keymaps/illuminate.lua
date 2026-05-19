---@module 'lazy'
---@type LazySpec
return {
  'RRethy/vim-illuminate',
  keys = {
    { '<leader>ui', function() require('utils').illuminate_toggle() end, desc = 'Toggle Illuminate LSP/treesitter' },
    {
      '<2-LeftMouse>',
      function() require('utils').illuminate_toggle() end,
      expr = true,
      desc = 'Toggle Illuminate LSP/treesitter',
    },
  },
}
