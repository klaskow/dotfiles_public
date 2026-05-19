local M = {}

M.attach = function(bufnr)
  local gs = require('gitsigns')
  local map = function(mode, l, r, opts)
    vim.keymap.set(mode, l, r, vim.tbl_extend('force', { buffer = bufnr }, opts or {}))
  end

  -- Navigation
  map('n', ']h', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gs.nav_hunk('next')
    end
  end, { desc = 'Next Git Hunk' })

  map('n', '[h', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gs.nav_hunk('prev')
    end
  end, { desc = 'Prev Git Hunk' })

  map('n', ']H', function() gs.nav_hunk('last') end, { desc = 'Last Git Hunk' })
  map('n', '[H', function() gs.nav_hunk('first') end, { desc = 'First Git Hunk' })

  -- Stage / Reset
  map(
    'v',
    '<leader>hs',
    function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
    { desc = 'Git Stage Hunk' }
  )
  map(
    'v',
    '<leader>hr',
    function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
    { desc = 'Git Reset Hunk' }
  )
  map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git Stage Hunk' })
  map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git Reset Hunk' })
  map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git Stage Buffer' })
  map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git Reset Buffer' })

  -- Preview / Blame / Diff
  map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git Preview Hunk' })
  map('n', '<leader>hi', gs.preview_hunk_inline, { desc = 'Git Preview Hunk Inline' })
  map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Git Blame Line' })
  map('n', '<leader>hd', gs.diffthis, { desc = 'Git Diff Against Index' })
  map('n', '<leader>hD', function() gs.diffthis('@') end, { desc = 'Git Diff Against Last Commit' })

  -- Quickfix
  map('n', '<leader>hq', gs.setqflist, { desc = 'Quickfix: unstaged (buffer)' })
  map('n', '<leader>hQ', function() gs.setqflist('all') end, { desc = 'Quickfix: unstaged' })

  local function git_hunks_qf(arg, empty_msg)
    local root = vim.fs.root(0, '.git') or vim.fn.getcwd()
    local items, file = {}, nil
    for _, line in ipairs(vim.fn.systemlist({ 'git', '-C', root, 'diff', '--unified=0', arg })) do
      local f = line:match('^%+%+%+ b/(.+)$')
      if f then file = root .. '/' .. f end
      local lnum = file and line:match('^@@[^+]*%+(%d+)')
      if lnum then
        items[#items + 1] =
          { filename = file, lnum = tonumber(lnum), col = 0, text = line:match('(@@ .+ @@.*)') or line }
      end
    end
    if #items == 0 then return vim.notify(empty_msg, vim.log.levels.INFO) end
    vim.fn.setqflist(items, 'r')
    vim.cmd('copen')
  end
  map('n', '<leader>hZ', function() git_hunks_qf('--cached', 'No staged hunks') end, { desc = 'Quickfix: staged' })
  map('n', '<leader>hA', function() git_hunks_qf('HEAD', 'No hunks') end, { desc = 'Quickfix: HEAD' })

  -- Text object
  map({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'Inside Git Hunk' })
end

return M
