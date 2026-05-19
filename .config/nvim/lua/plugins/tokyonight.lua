---@module 'lazy'
---@type LazySpec
return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup({
      transparent = true,
      styles = {
        comments = { italic = true },
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_highlights = function(hl, c)
        hl.LineNr = { fg = c.comment }
        hl.LineNrAbove = { fg = c.comment }
        hl.LineNrBelow = { fg = c.comment }
        hl.CursorLine = { bg = 'NONE' }
        hl.CursorLineNr = { fg = c.yellow, bold = true }
        hl.MiniStatuslineInactive = { fg = c.fg, bg = 'NONE' }
        hl.MiniStatuslineFilename = { fg = c.fg, bg = 'NONE' }
        hl.MiniStatuslineModeOther = { fg = c.fg, bg = 'NONE' }
        hl.StatusLine = { bg = 'NONE' }
        hl.StatusLineNC = { bg = 'NONE' }
        hl.TabLine = { fg = c.fg, bg = c.bg_dark }
        hl.Folded = { fg = c.blue, bg = 'NONE' }
        hl.MiniPickMatchCurrent = { bg = c.bg_highlight, bold = true }
      end,
    })
    vim.cmd.colorscheme('tokyonight')
  end,
}
