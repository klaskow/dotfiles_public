---@module 'lazy'
---@type LazySpec
return {
  'MagicDuck/grug-far.nvim',
  keys = {
    {
      '<leader>sr',
      function()
        local grug = require('grug-far')
        local ext = vim.bo.buftype == '' and vim.fn.expand('%:e') or nil
        grug.open({ transient = true, prefills = { filesFilter = ext and ext ~= '' and ('*.' .. ext) or nil } })
      end,
      mode = { 'n', 'v' },
      desc = 'Search and Replace',
    },
  },
}
