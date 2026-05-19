---@module 'lazy'
---@type LazySpec
return {
  'folke/flash.nvim',
  keys = {
    { '<Leader>s', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' },
    {
      '<Leader>S',
      function() require('flash').treesitter() end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash Treesitter',
    },
    {
      '<Leader>r',
      function() require('flash').remote() end,
      mode = 'o',
      desc = 'Remote Flash',
    },
    {
      '<Leader>R',
      function() require('flash').treesitter_search() end,
      mode = { 'x', 'o' },
      desc = 'Treesitter Search',
    },
  },
}
