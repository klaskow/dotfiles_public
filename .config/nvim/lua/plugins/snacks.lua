---@module 'lazy'
---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      sources = {
        files = { follow = true },
        grep = { follow = true },
      },
      actions = {
        picker_list_up_echo_path = require('utils').picker_list_up_echo_path,
        picker_list_down_echo_path = require('utils').picker_list_down_echo_path,
        picker_yank_rel_path = require('utils').picker_yank_rel_path,
        picker_open_with_default_app = require('utils').picker_open_with_default_app,
        picker_open_parent_dir = require('utils').picker_open_parent_dir,
      },
      win = {
        input = {
          keys = {
            ['<C-p>'] = { 'picker_list_up_echo_path', mode = { 'i', 'n' }, desc = 'picker_list_up_echo_path' },
            ['<C-n>'] = { 'picker_list_down_echo_path', mode = { 'i', 'n' }, desc = 'picker_list_down_echo_path' },
            ['<C-y>'] = { 'picker_yank_rel_path', mode = { 'i', 'n' }, desc = 'picker_yank_rel_path' },
            ['<leader>o'] = { 'picker_open_with_default_app', mode = { 'n' }, desc = 'picker_open_with_default_app' },
            ['<leader>O'] = { 'picker_open_parent_dir', mode = { 'n' }, desc = 'picker_open_parent_dir' },
          },
        },
      },
    },
  },
}
