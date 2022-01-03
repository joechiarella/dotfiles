set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.vimrc
set nocompatible              " be iMproved, required
filetype off                  " required

set splitright
set splitbelow
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set rnu
set noshowmode
set scrolloff=8
set updatetime=50

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

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

set rtp+=/usr/local/opt/fzf " after installing fzf through: brew install fzf
" set the runtime path to include Vundle and initialize

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Plug 'tpope/vim-rails'
" Plug 'majutsushi/tagbar'
" Plug 'tpope/vim-fugitive'
" Plug 'wycats/nerdtree'
" Plug 'junegunn/fzf.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'janko/vim-test'
Plug 'elixir-editors/vim-elixir'
" Plug 'scrooloose/syntastic'
Plug 'tpope/vim-sensible'
Plug 'isRuslan/vim-es6'
" Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
" Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ThePrimeagen/vim-be-good'

Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'preservim/vimux'


" color scheme
Plug 'flrnprz/plastic.vim'
Plug 'ajmwagar/vim-deus'
Plug 'bluz71/vim-nightfly-guicolors'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

call plug#end()
" All of your Plugs must be added before the following line
" call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
colorscheme nightfly


"
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plug stuff after this line
"
nnoremap <SPACE> <Nop>
let mapleader = " "
" map <Leader>n :set number! <CR>
" map <Leader>h :History <CR>
" map <Leader>a :Ag <CR>
" map <Leader>l :Lines <CR>
map <Leader>y :let @*=expand("%:p")<CR>
map <Leader>z :let @*=(expand("%:p") . ":" . line("."))<CR>
" map <Leader>t :term<CR>
map <Leader>c :%s/\s\+$//e<CR>
" map <Leader>gb :Gbrowse<CR>
map <leader>r :Ranger<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <leader>vz :VimuxZoomRunner<CR>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

map <C-L> :bnext<CR>
map <C-H> :bprev<CR>

syntax off
set background=dark
filetype plugin indent on

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

set re=1
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << END
require'lualine'.setup({
  options = {
    theme = 'auto',
    icons_enabled = true
  },  
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = { {
        'encoding'
      }, {
        'fileformat',
        icons_enabled = false
      }, {
        'filetype',
        icons_enabled = false
      } },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
})
END
