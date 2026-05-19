---@module 'lazy'
---@type LazySpec
return {
  'HiPhish/rainbow-delimiters.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
      },
    }
  end,
}
