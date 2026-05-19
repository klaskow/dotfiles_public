---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    delay = 300,
    icons = { mappings = vim.g.have_nerd_font },
  },
}
