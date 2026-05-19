---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  keys = {
    { '<leader>cf', function() require('conform').format({ async = true }) end, mode = '', desc = 'Format Buffer' },
    {
      '<leader>cF',
      function() require('conform').format({ async = true, formatters = { 'injected' } }) end,
      mode = { 'n', 'v' },
      desc = 'Format Injected Langs',
    },
  },
}
