---@module 'lazy'
---@type LazySpec
return {
  'folke/trouble.nvim',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cS',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP references/definitions (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '[x',
      function() require('trouble').prev({ skip_groups = true, jump = true }) end,
      desc = 'Prev Trouble Item',
    },
    {
      ']x',
      function() require('trouble').next({ skip_groups = true, jump = true }) end,
      desc = 'Next Trouble Item',
    },
  },
}
