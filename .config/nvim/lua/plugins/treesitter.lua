---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  config = function()
    local parsers = {
      'bash',
      'c',
      'css',
      'diff',
      'go',
      'gomod',
      'gowork',
      'graphql',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'scss',
      'toml',
      'tsx',
      'kotlin',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    }
    require('nvim-treesitter').install(parsers)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      if not vim.treesitter.language.add(language) then return end
      vim.treesitter.start(buf, language)
      local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
      if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
    end

    local ts_exclude = { csv = true, tsv = true, text = true }
    local available_parsers = require('nvim-treesitter').get_available()
    local installed_parsers_cache
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        if ts_exclude[filetype] then return end

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        installed_parsers_cache = installed_parsers_cache or require('nvim-treesitter').get_installed('parsers')
        local installed_parsers = installed_parsers_cache

        if vim.tbl_contains(installed_parsers, language) then
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          require('nvim-treesitter').install(language):await(function()
            installed_parsers_cache = nil
            treesitter_try_attach(buf, language)
          end)
        else
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
}
