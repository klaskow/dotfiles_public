---@module 'lazy'
---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('keymaps-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
        end

        -- Navigation
        map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
        map('<Leader>gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
        map('<Leader>gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declaration')
        map('<Leader>gi', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
        map('<Leader>gt', function() Snacks.picker.lsp_type_definitions() end, 'Goto Type Definition')
        map('<Leader>gr', function() Snacks.picker.lsp_references() end, 'Goto References')

        -- Symbols
        map('<Leader>gO', function() Snacks.picker.lsp_symbols() end, 'Document Symbols')
        map('<Leader>gW', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace Symbols')

        -- Documentation
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<C-h>', vim.lsp.buf.hover, 'Hover Documentation', 'i')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

        -- Actions
        map('<Leader>gn', vim.lsp.buf.rename, 'Rename')
        map('<Leader>gR', function() Snacks.rename.rename_file() end, 'Rename File')
        map('<Leader>ga', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
        map('<Leader>ga', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
        map('<Leader>gx', vim.lsp.codelens.run, 'Run CodeLens')
      end,
    })
  end,
}
