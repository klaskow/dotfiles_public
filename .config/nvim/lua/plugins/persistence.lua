---@module 'lazy'
---@type LazySpec
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  ---@module 'persistence'
  ---@type Persistence.Config
  opts = {},
}
