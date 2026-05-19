---@module 'lazy'
---@type LazySpec
return {
  'folke/flash.nvim',
  event = 'VimEnter',
  ---@module 'flash'
  ---@type Flash.Config
  opts = {
    label = {
      rainbow = {
        enabled = true,
        shade = 9,
      },
    },
    highlight = {
      backdrop = false,
    },
  },
}
