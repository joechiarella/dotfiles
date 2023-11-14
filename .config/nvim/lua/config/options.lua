-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.shada = "!,'1000,<50,s10,h"
vim.opt.background = "dark"
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.title = true
vim.opt.titlestring = "%{substitute(getcwd(),$HOME,'~','')}"

vim.g.neoterm_default_mod = "vertical"
vim.g.neoterm_autoscroll = 1

vim.cmd([[
tnoremap <Esc> <C-\><C-n>

let g:test#runner_commands = ['ExUnit']
let test#strategy = "neoterm"
let test#neovim#term_position = "vert"
let test#elixir#patterns = {
  \ 'test':      ['\v^\s*test (".+") do'],
\}
]])
