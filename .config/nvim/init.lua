--set runtimepath^=~/.vim runtimepath+=~/.vim/after
--let &packpath = &runtimepath
vim.opt.compatible = false

vim.opt.shada = "!,'1000,<50,s10,h"

vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.rnu = false
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "100"
vim.cmd("hi ColorColumn guibg=#080808")
vim.opt.hlsearch = false

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true

vim.opt.title = true
vim.opt.titlestring = "%{substitute(getcwd(),$HOME,'~','')}"

vim.opt.clipboard = "unnamed"
vim.opt.termguicolors = true

vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", { noremap = true })
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})

--vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

vim.opt.background = "dark"

vim.opt.re = 1

vim.cmd([[
tnoremap <Esc> <C-\><C-n>

let g:test#runner_commands = ['ExUnit']
let test#strategy = "neoterm"
let test#neovim#term_position = "vert"
let test#elixir#patterns = {
  \ 'test':      ['\v^\s*test (".+") do'],
\}
let g:neoterm_default_mod = "vertical"
let g:neoterm_autoscroll = 1

xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

]])
vim.opt.laststatus = 3
