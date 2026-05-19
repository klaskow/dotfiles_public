---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  keys = {
    {
      '\\',
      ':Neotree reveal<CR>',
      desc = 'NeoTree Reveal',
      silent = true,
    },
    {
      '<leader>e',
      function() require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() }) end,
      desc = 'Explorer (cwd)',
    },
    {
      '<leader>E',
      function() require('neo-tree.command').execute({ toggle = true, reveal = true }) end,
      desc = 'Explorer (reveal file)',
    },
    {
      '<leader>fe',
      function() require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() }) end,
      desc = 'Explorer (cwd)',
    },
    {
      '<leader>fE',
      function() require('neo-tree.command').execute({ toggle = true, reveal = true }) end,
      desc = 'Explorer (reveal file)',
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = { ['\\'] = 'close_window' },
      },
    },
  },
}
