vim.opt_local.spell = true
vim.opt_local.spelllang = { 'pl', 'en' }
vim.diagnostic.enable(false, { bufnr = 0 })

local spec_pair = require('mini.ai').gen_spec.pair
vim.b.miniai_config = {
  custom_textobjects = {
    ['*'] = spec_pair('*', '*', { type = 'greedy' }),
    ['_'] = spec_pair('_', '_', { type = 'greedy' }),
    ['`'] = spec_pair('`', '`', { type = 'greedy' }),
  },
}

local function _toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  if vim.v.count > 0 then
    vim.api.nvim_set_current_line('- [x] ' .. line)
  elseif line:match('%[ %]') then
    vim.api.nvim_set_current_line((line:gsub('%[ %]', '[x]')))
  elseif line:match('%[x%]') then
    vim.api.nvim_set_current_line((line:gsub('%[x%]', '[ ]')))
  else
    vim.api.nvim_set_current_line('- [ ] ' .. line)
  end
end

local function add_checkbox_and_insert()
  local line = vim.api.nvim_get_current_line()
  if vim.v.count > 0 then
    vim.api.nvim_set_current_line('- [x] ' .. line)
    return ''
  end
  if line == '' then return 'i- [ ] ' end
  if line:match('%[[ x]%]') then return 'A' end
  vim.api.nvim_set_current_line('- [ ] ' .. line)
  return 'A'
end

_G.__md_toggle_checkbox = _toggle_checkbox

local function toggle_checkbox()
  vim.o.operatorfunc = 'v:lua.__md_toggle_checkbox'
  return 'g@l'
end

local function insert_date() vim.api.nvim_put({ tostring(os.date('%Y-%m-%d')) }, 'c', true, true) end

local function continue_list()
  local line = vim.api.nvim_get_current_line()
  if line:match('^%s*- %[[ x]%]%s*$') then
    return '<C-u><CR>'
  elseif line:match('^%s*- %[[ x]%] ') then
    return '<CR>- [ ] '
  elseif line:match('^%s*[-*+]%s*$') then
    return '<C-u><CR>'
  elseif line:match('^%s*[-*+] ') then
    return '<CR>- '
  end
  return '<CR>'
end

local map = vim.keymap.set
map('n', '<leader>mx', toggle_checkbox, { buffer = true, expr = true, desc = 'Toggle Checkbox' })
map('n', '<leader>mX', add_checkbox_and_insert, { buffer = true, expr = true, desc = 'Add Checkbox and Insert' })
map('n', '<leader>md', insert_date, { buffer = true, desc = 'Insert Date (YYYY-MM-DD)' })
map('i', '<CR>', continue_list, { buffer = true, expr = true, desc = 'Continue List' })
