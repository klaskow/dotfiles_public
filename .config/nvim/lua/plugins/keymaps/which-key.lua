---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  keys = {
    {
      '<C-W><Space>',
      function() require('which-key').show({ keys = '<C-w>', loop = true }) end,
      desc = 'Window Hydra Mode (which-key)',
    },
    {
      '<leader>?',
      function() require('which-key').show({ global = false }) end,
      desc = 'Buffer Keymaps (which-key)',
    },
  },
  opts = {
    spec = {
      { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
      { '<leader>f', group = 'File/Find' },
      { '<leader>x', group = 'Diagnostics/Quickfix' },
      { '<leader>u', group = 'UI' },
      { '<leader>b', group = 'Buffers' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Debug' },
      { '<leader>w', group = 'Window' },
      { '<leader>q', group = 'Quit/Session' },
      { '<leader>n', group = 'Notifications' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Git Hunks', mode = { 'n', 'v' } },
      { '<leader>dp', group = 'Profiler' },
      { 'gr', group = 'LSP', mode = { 'n' } },
      { '[', group = 'Prev' },
      { ']', group = 'Next' },
      { '<leader><tab>', group = 'Tabs' },
    },
  },
}
