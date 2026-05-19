local M = {}

local function picker_rel_path(picker)
  local item = picker:current()
  if not item then return end
  return vim.fn.fnamemodify(Snacks.picker.util.path(item) or '', ':.')
end

local function echo(text) vim.api.nvim_echo({ { text, 'Normal' } }, false, {}) end

function M.picker_list_up_echo_path(picker)
  Snacks.picker.actions.list_up(picker)
  local path = picker_rel_path(picker)
  if path then echo(path) end
end

function M.picker_list_down_echo_path(picker)
  Snacks.picker.actions.list_down(picker)
  local path = picker_rel_path(picker)
  if path then echo(path) end
end

function M.picker_yank_rel_path(picker)
  local path = picker_rel_path(picker)
  if path then
    vim.fn.setreg('+', path)
    echo('Copied: ' .. path)
  end
end

local function picker_abs_path(picker)
  local item = picker:current()
  if not item then return end
  return Snacks.picker.util.path(item)
end

local open_cmd = vim.uv.os_uname().sysname == 'Darwin' and 'open' or 'xdg-open'

function M.picker_open_with_default_app(picker)
  local path = picker_abs_path(picker)
  if not path then return end
  -- picker:close()
  vim.fn.jobstart({ open_cmd, path }, { detach = true })
end

function M.picker_open_parent_dir(picker)
  local path = picker_abs_path(picker)
  if not path then return end
  local dir = vim.fn.fnamemodify(path, ':h')
  -- picker:close()
  vim.fn.jobstart({ open_cmd, dir }, { detach = true })
end

function M.open_current_file_with_default_app()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  vim.fn.jobstart({ open_cmd, path }, { detach = true })
end

function M.open_current_file_parent_dir()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  vim.fn.jobstart({ open_cmd, vim.fn.fnamemodify(path, ':h') }, { detach = true })
end

function M.illuminate_toggle()
  local ill = require('illuminate')
  local lsp = not vim.g.illuminate_lsp
  vim.g.illuminate_lsp = lsp
  ill.configure({ providers = lsp and { 'lsp', 'treesitter', 'regex' } or { 'treesitter', 'regex' } })
  vim.api.nvim_exec_autocmds('CursorMoved', { buffer = 0 })
  vim.notify('Illuminate: ' .. (lsp and 'LSP (semantic)' or 'treesitter'), vim.log.levels.INFO)
end

function M.navic_attach(client, bufnr)
  require('nvim-navic').attach(client, bufnr)
  client:request(
    'textDocument/documentSymbol',
    { textDocument = vim.lsp.util.make_text_document_params(bufnr) },
    function(err)
      if err or not vim.api.nvim_buf_is_valid(bufnr) then return end
      vim.api.nvim_exec_autocmds('CursorMoved', { buffer = bufnr })
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(bufnr) then vim.cmd('redrawstatus!') end
      end, 10)
    end,
    bufnr
  )
end

return M
