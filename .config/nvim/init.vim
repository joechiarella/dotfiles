set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.vimrc
set nocompatible              " be iMproved, required
filetype off                  " required

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
" set colorcolumn=80
set nohlsearch

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set title titlestring=%{substitute(getcwd(),$HOME,'~','')}

" let g:airline_powerline_fonts = 1
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
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

lua require('plugins')

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" colorscheme nightfly
colorscheme catppuccin

nnoremap <SPACE> <Nop>
let mapleader = " "
" map <Leader>n :set number! <CR>
" map <Leader>h :History <CR>
" map <Leader>a :Ag <CR>
" map <Leader>l :Lines <CR>

map <Leader> <Plug>(easymotion-prefix)
map <Leader>y :let @*=expand("%:p")<CR>
map <Leader>z :let @*=(expand("%:p") . ":" . line("."))<CR>
" map <Leader>t :term<CR>
map <Leader>c :%s/\s\+$//e<CR>
" map <Leader>gb :Gbrowse<CR>
map <leader>r :Ranger<CR>

" Prompt for a command to run
 map <Leader>vp :VimuxPromptCommand<CR>

 " Run last command executed by VimuxRunCommand
 map <Leader>vl :VimuxRunLastCommand<CR>

 " Inspect runner pane
 map <Leader>vi :VimuxInspectRunner<CR>

 " Close vim tmux runner opened by VimuxRunCommand
 map <Leader>vq :VimuxCloseRunner<CR>

 " Interupt any command running in the runner pane
 map <Leader>vx :VimuxInterruptRunner<CR>

 " Zoom the runner pane (use <bind-key> z to restore runner pane)
 map <Leader>vz :call VimuxZoomRunner()<CR>

 " Clear the terminal screen of the runner pane.
 map <Leader>v<C-l> :VimuxClearTerminalScreen<CR>

nnoremap <leader>h :HardTimeToggle<CR>
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap <leader>fi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles({cwd_only=true})<cr>

nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv
map <C-L> :bnext<CR>
map <C-H> :bprev<CR>

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

let g:VimuxOrientation = "h"
let g:VimuxHeight = "40"

" let g:mix_format_on_save = 1

" Nerd tree stuff
" map <C-p> :NERDTreeToggle<CR>
" Close window if only nerd tree left
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"vim-test settings
" let test#vim#term_position="belowright"
" let g:test#strategy='vimterminal'
" let test#ruby#rspec#executable = 'bundle exec rspec'

" syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" airline settings
" let g:airline#extensions#tabline#enabled = 1
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'elixir': ['credo'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'elixir': ['mix_format'],
\   'ruby': ['rubocop']
\}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

set re=1

let g:coq_settings = { 'auto_start': 'shut-up' }
