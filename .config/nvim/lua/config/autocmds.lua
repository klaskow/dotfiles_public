local function augroup(name) return vim.api.nvim_create_augroup('autocmds_' .. name, { clear = true }) end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd('checktime') end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Snacks dim: narrow scope for csv files (1 line), default for everything else
local dim_min, dim_max
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('snacks_dim_dynamic'),
  callback = function()
    if not (_G.Snacks and Snacks.config.dim) then return end
    local cfg = Snacks.config.dim
    if type(cfg) ~= 'table' then
      cfg = {}
      Snacks.config.dim = cfg
    end
    if not cfg.scope then cfg.scope = {} end

    if dim_min == nil then
      dim_min = cfg.scope.min_size or 5
      dim_max = cfg.scope.max_size or 20
    end

    if vim.bo.filetype == 'csv' then
      cfg.scope.min_size, cfg.scope.max_size = 1, 1
    else
      cfg.scope.min_size, cfg.scope.max_size = dim_min, dim_max
    end

    if Snacks.dim.enabled then Snacks.dim.setup() end
  end,
})

-- Enable codelens auto-refresh when an LSP with codeLensProvider attaches
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('codelens_enable'),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
