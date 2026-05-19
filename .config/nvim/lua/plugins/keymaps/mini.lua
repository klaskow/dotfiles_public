local M = {}
M.ai_textobjects = function()
  local ai = require('mini.ai')
  local extra = require('mini.extra')
  return {
    -- Treesitter
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
    a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
    A = ai.gen_spec.treesitter({ a = '@assignment.outer', i = '@assignment.inner' }),
    r = ai.gen_spec.treesitter({ a = '@return.outer', i = '@return.inner' }),
    x = ai.gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),

    -- mini.extra
    B = extra.gen_ai_spec.buffer(),
    D = extra.gen_ai_spec.diagnostic(),
    I = extra.gen_ai_spec.indent(),
    L = extra.gen_ai_spec.line(),
    N = extra.gen_ai_spec.number(),

    -- Cały bufor
    g = function()
      local from = { line = 1, col = 1 }
      local last_line = vim.fn.line('$')
      local last_col = math.max(vim.fn.getline(last_line):len(), 1)
      return { from = from, to = { line = last_line, col = last_col } }
    end,
  }
end

local files_toggle = function(path)
  if not MiniFiles.close() then MiniFiles.open(path) end
end

M.keys = {
  { '<leader>mo', function() MiniDiff.toggle_overlay() end,  desc = 'Mini Diff Overlay' },
  { '<leader>gc', function() MiniGit.show_at_cursor() end,  desc = 'Git Show at Cursor', mode = { 'n', 'x' } },
  { '<leader>gv', '<Cmd>vert Git blame -- %<CR>',           desc = 'Git Blame (vertical)' },
  {
    '<leader>fd',
    function() MiniExtra.pickers.explorer({ cwd = vim.fn.expand('%:p:h') }) end,
    desc = 'Explorer (file dir)',
  },
  {
    '<leader>mt',
    function() MiniExtra.pickers.treesitter() end,
    desc = 'Mini Treesitter',
  },
  {
    '<leader>ms',
    function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,
    desc = 'Mini LSP Symbols',
  },
  {
    '<leader>mh',
    function() MiniExtra.pickers.git_hunks() end,
    desc = 'Mini Git Hunks (unstaged)',
  },
  {
    '<leader>mH',
    function() MiniExtra.pickers.git_hunks({ scope = 'staged' }) end,
    desc = 'Mini Git Hunks (staged)',
  },
  {
    '<leader>mv',
    function() MiniExtra.pickers.visit_paths() end,
    desc = 'Mini Visits (cwd)',
  },
  {
    '<leader>mV',
    function() MiniExtra.pickers.visit_paths({ cwd = '' }) end,
    desc = 'Mini Visits (global)',
  },
  {
    '<leader>fm',
    function() files_toggle() end,
    desc = 'Mini Files (cwd)',
  },
  {
    '<leader>fM',
    function() files_toggle(vim.api.nvim_buf_get_name(0)) end,
    desc = 'Mini Files (file dir)',
  },
}

return M
