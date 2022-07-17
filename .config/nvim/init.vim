set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.vimrc
set nocompatible              " be iMproved, required
filetype off                  " required

set shada=!,'1000,<50,s10,h

set nowrap
set splitright
set splitbelow
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set nornu
set noshowmode
set scrolloff=8
set updatetime=50
set colorcolumn=100
hi ColorColumn guibg=#080808
set nohlsearch

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set title titlestring=%{substitute(getcwd(),$HOME,'~','')}

" generic settings
let g:ruby_path = system('echo $HOME/.rbenv/shims')
set clipboard=unnamed  " use system clipboard
set termguicolors
" set Vim-specific sequences for RGB colors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:ranger_map_keys = 0
" let g:lightline = { 'colorscheme': 'nightfly' }

" set rtp+=/usr/local/opt/fzf " after installing fzf through: brew install fzf
" set the runtime path to include Vundle and initialize

nnoremap <SPACE> <Nop>
let mapleader = " "

let g:coq_settings = { 'auto_start': 'shut-up' }

lua require('plugins')

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" colorscheme nightfly
colorscheme catppuccin

" map <Leader>n :set number! <CR>
" map <Leader>h :History <CR>
" map <Leader>a :Ag <CR>
" map <Leader>l :Lines <CR>

" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

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

" strip trailing whitespace off for certain file types
" autocmd FileType javascript,typescript,elixir,ruby autocmd BufWritePre <buffer> %s/\s\+$//e

set background=dark
filetype plugin indent on

set re=1

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

