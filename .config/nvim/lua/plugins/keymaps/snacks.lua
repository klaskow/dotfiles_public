---@module 'lazy'
---@type LazySpec
return {
  'folke/snacks.nvim',
  keys = {
    -- Git
    {
      '<leader>gg',
      function() Snacks.lazygit() end,
      desc = 'Lazygit (root dir)',
    },
    {
      '<leader>gG',
      function() Snacks.lazygit({ cwd = vim.uv.cwd() }) end,
      desc = 'Lazygit (cwd)',
    },
    {
      '<leader>gf',
      function() Snacks.lazygit.log_file() end,
      desc = 'Lazygit file log',
    },
    {
      '<leader>gl',
      function() Snacks.lazygit.log() end,
      desc = 'Lazygit log',
    },
    {
      '<leader>gB',
      function() Snacks.gitbrowse() end,
      desc = 'Git Browse (open)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gY',
      function()
        Snacks.gitbrowse({ open = function(url) vim.fn.setreg('+', url) end, notify = false })
      end,
      desc = 'Git Browse (copy)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gb',
      function() Snacks.git.blame_line() end,
      desc = 'Git Blame Line',
    },
    -- Terminal
    {
      '<C-/>',
      function() Snacks.terminal() end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<C-_>',
      function() Snacks.terminal() end,
      desc = 'which_key_ignore',
      mode = { 'n', 't' },
    },
    {
      '<leader>ft',
      function() Snacks.terminal() end,
      desc = 'Terminal (root)',
    },
    {
      '<leader>fT',
      function() Snacks.terminal(nil, { cwd = vim.uv.cwd() }) end,
      desc = 'Terminal (cwd)',
    },
    -- Notifications
    {
      '<leader>nh',
      function() Snacks.notifier.show_history() end,
      desc = 'Notification History',
    },
    {
      '<leader>nd',
      function() Snacks.notifier.hide() end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>un',
      function() Snacks.notifier.hide() end,
      desc = 'Dismiss All Notifications',
    },
    -- Zen / Zoom
    {
      '<leader>uz',
      function() Snacks.zen() end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>uZ',
      function() Snacks.zen.zoom() end,
      desc = 'Toggle Zoom Mode',
    },
    {
      '<leader>wm',
      function() Snacks.zen.zoom() end,
      desc = 'Toggle Zoom Mode',
    },
    -- Inspect
    {
      '<leader>ui',
      function() vim.show_pos() end,
      desc = 'Inspect Pos',
    },
    {
      '<leader>uI',
      '<cmd>InspectTree<cr>',
      desc = 'Inspect Tree',
    },
    -- Scratch / Profiler
    {
      '<leader>.',
      function() Snacks.scratch() end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function() Snacks.scratch.select() end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>dps',
      function() Snacks.profiler.scratch() end,
      desc = 'Profiler Scratch Buffer',
    },
    -- Picker: files
    {
      '<leader><leader>',
      function() Snacks.picker.files() end,
      desc = 'Find Files (Root Dir)',
    },
    {
      '<leader>,',
      function() Snacks.picker.buffers() end,
      desc = 'Buffers',
    },
    {
      '<leader>:',
      function() Snacks.picker.command_history() end,
      desc = 'Command History',
    },
    {
      '<leader>/',
      function() Snacks.picker.grep() end,
      desc = 'Grep (Root Dir)',
    },
    {
      '<leader>ff',
      function() Snacks.picker.files() end,
      desc = 'Find Files (Root Dir)',
    },
    {
      '<leader>fF',
      function() Snacks.picker.files({ hidden = true, ignored = true }) end,
      desc = 'Find Files (hidden)',
    },
    {
      '<leader>fb',
      function() Snacks.picker.buffers() end,
      desc = 'Buffers',
    },
    {
      '<leader>fB',
      function() Snacks.picker.buffers({ hidden = true }) end,
      desc = 'Buffers (all)',
    },
    {
      '<leader>fc',
      function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
      desc = 'Find Config File',
    },
    {
      '<leader>fg',
      function() Snacks.picker.git_files() end,
      desc = 'Find Files (git-files)',
    },
    {
      '<leader>fr',
      function() Snacks.picker.recent() end,
      desc = 'Recent',
    },
    {
      '<leader>fR',
      function() Snacks.picker.recent({ filter = { cwd = true } }) end,
      desc = 'Recent (cwd)',
    },
    -- Picker: git
    {
      '<leader>gs',
      function() Snacks.picker.git_status() end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function() Snacks.picker.git_stash() end,
      desc = 'Git Stash',
    },
    -- Picker: search
    {
      '<leader>s/',
      function() Snacks.picker.search_history() end,
      desc = 'Search History',
    },
    {
      '<leader>s"',
      function() Snacks.picker.registers() end,
      desc = 'Registers',
    },
    {
      '<leader>sa',
      function() Snacks.picker.autocmds() end,
      desc = 'Autocmds',
    },
    {
      '<leader>sb',
      function() Snacks.picker.lines() end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function() Snacks.picker.grep_buffers() end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sc',
      function() Snacks.picker.command_history() end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function() Snacks.picker.commands() end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function() Snacks.picker.diagnostics() end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function() Snacks.picker.diagnostics_buffer() end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sg',
      function() Snacks.picker.grep() end,
      desc = 'Grep (Root Dir)',
    },
    {
      '<leader>sG',
      function() Snacks.picker.grep({ cwd = vim.uv.cwd() }) end,
      desc = 'Grep (cwd)',
    },
    {
      '<leader>sh',
      function() Snacks.picker.help() end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function() Snacks.picker.highlights() end,
      desc = 'Highlights',
    },
    {
      '<leader>sj',
      function() Snacks.picker.jumps() end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function() Snacks.picker.keymaps() end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function() Snacks.picker.loclist() end,
      desc = 'Location List',
    },
    {
      '<leader>sM',
      function() Snacks.picker.man() end,
      desc = 'Man Pages',
    },
    {
      '<leader>sm',
      function() Snacks.picker.marks() end,
      desc = 'Marks',
    },
    {
      '<leader>sq',
      function() Snacks.picker.qflist() end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sR',
      function() Snacks.picker.resume() end,
      desc = 'Resume',
    },
    {
      '<leader>sw',
      function() Snacks.picker.grep_word() end,
      mode = { 'n', 'x' },
      desc = 'Visual selection or word (Root Dir)',
    },
    {
      '<leader>sW',
      function() Snacks.picker.grep_word({ cwd = vim.uv.cwd() }) end,
      mode = { 'n', 'x' },
      desc = 'Visual selection or word (cwd)',
    },
    {
      '<leader>uC',
      function() Snacks.picker.colorschemes() end,
      desc = 'Colorschemes',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
        Snacks.toggle.option('number', { name = 'Line Numbers' }):map('<leader>ul')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
        Snacks.toggle.option('conceallevel', { off = 0, on = 2, name = 'Conceal Level' }):map('<leader>uc')
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
        Snacks.toggle.option('showtabline', { off = 0, on = 2, name = 'Tabline' }):map('<leader>uA')
        Snacks.toggle.diagnostics():map('<leader>ud')
        Snacks.toggle.treesitter():map('<leader>uT')
        Snacks.toggle.inlay_hints():map('<leader>uh')
        Snacks.toggle.dim():map('<leader>uD')
        Snacks.toggle.animate():map('<leader>ua')
        Snacks.toggle.indent():map('<leader>ug')
        Snacks.toggle.scroll():map('<leader>uS')
        Snacks.toggle.profiler():map('<leader>dpp')
        Snacks.toggle.profiler_highlights():map('<leader>dph')

        Snacks.toggle({
          name = 'Auto Format (Global)',
          get = function() return not vim.g.disable_autoformat end,
          set = function(state) vim.g.disable_autoformat = not state end,
        }):map('<leader>uf')

        Snacks.toggle({
          name = 'Auto Format (Buffer)',
          get = function() return not (vim.b.disable_autoformat or vim.g.disable_autoformat) end,
          set = function(state) vim.b.disable_autoformat = not state end,
        }):map('<leader>uF')

        Snacks.toggle({
          name = 'Git Signs',
          get = function() return require('gitsigns.config').config.signcolumn end,
          set = function() require('gitsigns').toggle_signs() end,
        }):map('<leader>uG')

        Snacks.toggle({
          name = 'Git Blame Line',
          get = function() return require('gitsigns.config').config.current_line_blame end,
          set = function() require('gitsigns').toggle_current_line_blame() end,
        }):map('<leader>uB')

        Snacks.toggle({
          name = 'Git Word Diff',
          get = function() return require('gitsigns.config').config.word_diff end,
          set = function() require('gitsigns').toggle_word_diff() end,
        }):map('<leader>uW')

        Snacks.toggle({
          name = 'Navic Breadcrumbs',
          get = function() return vim.o.winbar ~= '' end,
          set = function(state) vim.o.winbar = state and "%{%v:lua.require('nvim-navic').get_location()%}" or '' end,
        }):map('<leader>uN')
      end,
    })
  end,
}
