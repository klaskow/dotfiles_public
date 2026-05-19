---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  keys = {
    {
      '<F7>',
      function() require('dapui').toggle() end,
      desc = 'Debug: Toggle UI',
    },
    {
      '<F8>',
      function() require('dap').continue() end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F10>',
      function() require('dap').step_over() end,
      desc = 'Debug: Step Over',
    },
    {
      '<F11>',
      function() require('dap').step_into() end,
      desc = 'Debug: Step Into',
    },
    {
      '<S-F11>',
      function() require('dap').step_out() end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>db',
      function() require('dap').toggle_breakpoint() end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = 'Set Breakpoint',
    },
  },
}
