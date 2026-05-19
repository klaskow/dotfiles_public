---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or '127.0.0.1'
        cb({ type = 'server', port = port, host = host, options = { source_filetype = 'python' } })
      else
        cb({
          type = 'executable',
          command = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
          args = { '-m', 'debugpy.adapter' },
          options = { source_filetype = 'python' },
        })
      end
    end

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
          if venv then return venv .. '/bin/python' end
          return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
        end,
      },
    }

    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and {
          Breakpoint = '',
          BreakpointCondition = '',
          BreakpointRejected = '',
          LogPoint = '',
          Stopped = '',
        }
      or {
        Breakpoint = '●',
        BreakpointCondition = '⊜',
        BreakpointRejected = '⊘',
        LogPoint = '◆',
        Stopped = '⭔',
      }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
          '${port}',
        },
      },
    }

    local attach_node = {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to process',
      port = function() return tonumber(vim.fn.input('Port: ', '9229')) end,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
    }

    -- tsx is a TypeScript runner for Node.js: npm install -g tsx
    local tsx_path = vim.fn.exepath('tsx')

    local ts_configurations = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file (Node 22+ strip-types)',
        runtimeExecutable = 'node',
        runtimeArgs = { '--experimental-strip-types' },
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
      },
      attach_node,
    }

    if tsx_path ~= '' then
      table.insert(ts_configurations, 2, {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file (tsx)',
        runtimeExecutable = tsx_path,
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
      })
    end

    dap.configurations.typescript = vim.deepcopy(ts_configurations)
    dap.configurations.typescriptreact = vim.deepcopy(ts_configurations)

    local js_configurations = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      attach_node,
    }

    dap.configurations.javascript = vim.deepcopy(js_configurations)
    dap.configurations.javascriptreact = vim.deepcopy(js_configurations)
  end,
}
