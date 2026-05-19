-- Search: first press highlights, subsequent * goes forward, # goes backward
local _highlighted_word = nil
local function star_search(forward)
  local word = vim.fn.expand('<cword>')
  local pattern = '\\<' .. word .. '\\>'
  if vim.o.hlsearch and _highlighted_word == word then
    vim.fn.search(pattern, forward and 'w' or 'bw')
    vim.v.searchforward = forward and 1 or 0
  else
    vim.fn.setreg('/', pattern)
    vim.v.searchforward = forward and 1 or 0
    vim.opt.hlsearch = true
    _highlighted_word = word
  end
end
vim.keymap.set('n', '*', function() star_search(true) end, { desc = 'Highlight/Next Word' })
vim.keymap.set('n', '#', function() star_search(false) end, { desc = 'Highlight/Prev Word' })

-- Search
vim.keymap.set({ 'i', 'n', 's' }, '<Esc>', function()
  vim.cmd('nohlsearch')
  return '<Esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })
vim.keymap.set(
  'n',
  '<leader>ur',
  '<Cmd>nohlsearch|diffupdate|normal! <C-L><CR>',
  { desc = 'Redraw / Clear hlsearch / Diff Update' }
)

-- Diagnostics
vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Location List (Diagnostics)' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next Diagnostic' })
vim.keymap.set(
  'n',
  '[e',
  function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Prev Error' }
)
vim.keymap.set(
  'n',
  ']e',
  function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end,
  { desc = 'Next Error' }
)
vim.keymap.set(
  'n',
  '[w',
  function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end,
  { desc = 'Prev Warning' }
)
vim.keymap.set(
  'n',
  ']w',
  function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end,
  { desc = 'Next Warning' }
)

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window management
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window' })
vim.keymap.set('n', '<leader>wo', '<C-W>o', { desc = 'Close Other Windows' })
vim.keymap.set('n', '<leader>ww', '<C-W>p', { desc = 'Other Window' })
vim.keymap.set('n', '<leader>w-', '<C-W>s', { desc = 'Split Window Below' })
vim.keymap.set('n', '<leader>w|', '<C-W>v', { desc = 'Split Window Right' })
vim.keymap.set('n', '<leader>ws', '<C-W>s', { desc = 'Split Window Below' })
vim.keymap.set('n', '<leader>wv', '<C-W>v', { desc = 'Split Window Right' })
vim.keymap.set('n', '<leader>w=', '<C-W>=', { desc = 'Equalize Windows' })
vim.keymap.set('n', '<leader>wx', '<C-W>x', { desc = 'Swap With Next' })
vim.keymap.set('n', '<leader>wH', '<C-W>H', { desc = 'Move Window Far Left' })
vim.keymap.set('n', '<leader>wJ', '<C-W>J', { desc = 'Move Window To Bottom' })
vim.keymap.set('n', '<leader>wK', '<C-W>K', { desc = 'Move Window To Top' })
vim.keymap.set('n', '<leader>wL', '<C-W>L', { desc = 'Move Window Far Right' })
vim.keymap.set('n', '<leader>wT', '<C-W>T', { desc = 'Break Out Into Tab' })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right' })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below' })

-- Resize windows
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase Window Width' })

-- Move lines
vim.keymap.set('n', '<M-j>', '<cmd>execute "move .+" . v:count1<CR>==', { desc = 'Move Line Down' })
vim.keymap.set('n', '<M-k>', '<cmd>execute "move .-" . (v:count1 + 1)<CR>==', { desc = 'Move Line Up' })
vim.keymap.set('v', '<M-j>', ":<C-U>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = 'Move Lines Down' })
vim.keymap.set('v', '<M-k>', ":<C-U>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = 'Move Lines Up' })

-- Centered half-page scroll
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll Down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll Up' })

-- Better j/k for wrapped lines
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down' })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up' })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down' })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up' })

-- Save file
vim.keymap.set({ 'i', 'n', 'x', 's' }, '<C-S>', '<cmd>w<CR><Esc>', { desc = 'Save File' })

-- Quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit All' })
vim.keymap.set('n', '<leader>qQ', '<cmd>qa!<CR>', { desc = 'Quit All (Force)' })
vim.keymap.set('n', '<leader>qw', '<cmd>wqa<CR>', { desc = 'Save All & Quit' })
vim.keymap.set('n', '<leader>qc', '<cmd>q<CR>', { desc = 'Quit Window' })

-- Tabs
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<CR>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<CR>', { desc = 'Prev Tab' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<CR>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<CR>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<CR>', { desc = 'Close Other Tabs' })

-- Files
vim.keymap.set('n', '<leader>fn', '<cmd>enew<CR>', { desc = 'New File' })

-- Buffers
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>bdelete!<CR>', { desc = 'Delete Buffer (Force)' })
-- Better n/N (centered + open folds)
vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zzzv'", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Quickfix / Location list navigation
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Prev Quickfix' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next Quickfix' })
vim.keymap.set('n', '[Q', '<cmd>cfirst<CR>', { desc = 'First Quickfix' })
vim.keymap.set('n', ']Q', '<cmd>clast<CR>', { desc = 'Last Quickfix' })
vim.keymap.set('n', '[l', '<cmd>lprev<CR>', { desc = 'Prev Loclist' })
vim.keymap.set('n', ']l', '<cmd>lnext<CR>', { desc = 'Next Loclist' })
vim.keymap.set('n', '[L', '<cmd>lfirst<CR>', { desc = 'First Loclist' })
vim.keymap.set('n', ']L', '<cmd>llast<CR>', { desc = 'Last Loclist' })

-- Keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<CR>', { desc = 'Keywordprg' })

-- Comments (below/above)
vim.keymap.set('n', 'gco', 'o<Esc>Vcx<Esc><cmd>normal gcc<CR>fxa<BS>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<Esc>Vcx<Esc><cmd>normal gcc<CR>fxa<BS>', { desc = 'Add Comment Above' })

-- Open current file / parent dir with default app
vim.keymap.set('n', '<leader>o', function() require('utils').open_current_file_with_default_app() end, { desc = 'Open File with Default App' })
vim.keymap.set('n', '<leader>O', function() require('utils').open_current_file_parent_dir() end, { desc = 'Open Parent Dir with Default App' })
