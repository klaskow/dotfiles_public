---@module 'lazy'
---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'mason-org/mason.nvim',
      ---@module 'mason.settings'
      ---@type MasonSettings
      ---@diagnostic disable-next-line: missing-fields
      opts = {},
    },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'SmiteshP/nvim-navic',
  },
  config = function()
    ---@type table<string, vim.lsp.Config>
    local servers = {
      ts_ls = {},
      pyright = {},
      ruff = {},
      eslint = {},
      cssls = {},
      yamlls = {},
      jsonls = {},
      html = {},
      emmet_language_server = {},
      gopls = {},
      kotlin_language_server = {},
      markdown_oxide = {
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          require('blink.cmp').get_lsp_capabilities(),
          {
            workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
          }
        ),
      },

      lua_ls = {
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = false

          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath('config')
              and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                '${3rd}/luv/library',
                '${3rd}/busted/library',
              }),
            },
          })
        end,
        ---@type lspconfig.settings.lua_ls
        settings = {
          Lua = {
            format = { enable = false },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'prettierd',
      'goimports',
      'shellcheck',
      'markdownlint',
      'js-debug-adapter',
      'debugpy',
      'kotlin-language-server',
      'ktlint',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end

    vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', { desc = 'LSP info' })

    -- Write all modified buffers after LSP rename (workspace edits to closed files are applied but not saved)
    local orig_rename_handler = vim.lsp.handlers['textDocument/rename']
    vim.lsp.handlers['textDocument/rename'] = function(err, result, ctx, config)
      local ei = vim.o.eventignore
      vim.o.eventignore = 'BufEnter,BufLeave,BufWinEnter,BufWinLeave,WinEnter,WinLeave'
      orig_rename_handler(err, result, ctx, config)
      vim.o.eventignore = ei
      if not err and result then vim.cmd('noautocmd wall') end
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-navic-attach', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not (client and client.server_capabilities.documentSymbolProvider) then return end

        require('utils').navic_attach(client, args.buf)
      end,
    })
  end,
}
