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

require("plugins")

vim.cmd("colorscheme catppuccin")

vim.cmd([[
" ******* highlight-current-n plugin
nmap n <Plug>(highlight-current-n-n)
nmap N <Plug>(highlight-current-n-N)

nmap * *N

" Some QOL autocommands
augroup ClearSearchHL
  autocmd!
  " You may only want to see hlsearch /while/ searching, you can automatically
  " toggle hlsearch with the following autocommands
  autocmd CmdlineEnter /,\? set hlsearch
  autocmd CmdlineLeave /,\? set nohlsearch
  " this will apply similar n|N highlighting to the first search result
  " careful with escaping ? in lua, you may need \\?
  autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
augroup END

syntax off
  ]])

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
