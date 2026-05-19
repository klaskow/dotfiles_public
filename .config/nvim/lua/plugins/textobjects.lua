---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  event = 'VeryLazy',
  opts = {
    move = {
      enable = true,
      set_jumps = true,
    },
  },
  config = function(_, opts)
    require('nvim-treesitter-textobjects').setup(opts)

    local function attach(buf)
      local moves = vim.tbl_get(opts, 'move', 'keys') or {}
      for method, keymaps in pairs(moves) do
        for key, spec in pairs(keymaps) do
          local query = type(spec) == 'table' and spec.query or spec
          local desc = type(spec) == 'table' and spec.desc or key
          vim.keymap.set(
            { 'n', 'x', 'o' },
            key,
            function() require('nvim-treesitter-textobjects.move')[method](query, 'textobjects') end,
            { buffer = buf, silent = true, desc = desc }
          )
        end
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter_textobjects', { clear = true }),
      callback = function(ev) attach(ev.buf) end,
    })
    vim.tbl_map(attach, vim.api.nvim_list_bufs())
  end,
}
