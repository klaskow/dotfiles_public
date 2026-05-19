---@module 'lazy'
---@type LazySpec
return {
  'nvim-mini/mini.nvim',
  lazy = false,
  config = function()
    require('mini.pairs').setup()
    require('mini.git').setup()
    require('mini.diff').setup({
      view = { style = 'number' },
      mappings = {
        goto_first = '',
        goto_prev  = '',
        goto_next  = '',
        goto_last  = '',
      },
    })
    require('mini.bracketed').setup()
    require('mini.pick').setup({
      window = { config = { border = 'rounded' } },
    })
    require('mini.operators').setup()
    require('mini.comment').setup()
    require('mini.move').setup()
    require('mini.extra').setup()
    require('mini.visits').setup()
    require('mini.files').setup({
      windows = { preview = true, width_focus = 40, width_preview = 60 },
    })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowOpen',
      callback = function(args)
        local config = vim.api.nvim_win_get_config(args.data.win_id)
        config.border = 'rounded'
        vim.api.nvim_win_set_config(args.data.win_id, config)
      end,
    })

    local ai = require('mini.ai')
    ai.setup({
      n_lines = 500,
      custom_textobjects = require('plugins.keymaps.mini').ai_textobjects(),
    })

    require('mini.surround').setup({
      mappings = require('plugins.keymaps.mini').surround_mappings,
    })

    local statusline = require('mini.statusline')
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v|%p%%' end
  end,
  keys = require('plugins.keymaps.mini').keys,
}
