vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'takac/vim-hardtime'
  use 'tpope/vim-sensible'
  use {
    "mickael-menu/zk-nvim",
    config = function ()
      require("zk").setup({
        picker = "telescope",
      })
    end
  }
  -- use 'isRuslan/vim-es6'
  use {"ellisonleao/glow.nvim"}

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
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
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true
        }
      }
    end
  }

  use 'nvim-treesitter/playground'


  use 'ThePrimeagen/vim-be-good'
  use 'ggandor/lightspeed.nvim'
  use 'francoiscabrol/ranger.vim'
  use 'rbgrouleff/bclose.vim'
  use 'preservim/vimux'
  use 'dense-analysis/ale'
  -- use 'flrnprz/plastic.vim'
  -- use 'ajmwagar/vim-deus'
  use 'bluz71/vim-nightfly-guicolors'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function ()
      require('telescope').setup{
        defaults = {
          path_display = { truncate = 3 },
          layout_strategy = 'horizontal',
          layout_config = { height = 0.95, width = 0.95 },
          dynamic_preview_title = true,
        --  file_previewer = require'telescope.previewers'.cat.new,
        },
        extensions = {
          frecency = {
            show_scores = true,
            show_unindexed = true,
            default_workspace = 'CWD',
          }
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            sort_mru = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              }
            }
          }
        }
      }
      require('telescope').load_extension('fzy_native')
    end
  }

  use 'nvim-telescope/telescope-fzy-native.nvim'


  use {
    'neovim/nvim-lspconfig',
  }

  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)


  end


  -- vim.lsp.set_log_level("debug")
  require'lspconfig'.solargraph.setup{
    on_attach = on_attach,
  }
  require'lspconfig'.elixirls.setup{
      -- Unix
      on_attach = on_attach,
      settings = {
        dialyzerFormat = "dialyxir_long",
      },
      cmd = { "/Users/joechiarella/.lsp/elixir-ls/language_server.sh" };
  }

  use { 'ms-jpq/coq_nvim' }
  use { 'ms-jpq/coq.artifacts' }

  use 'rktjmp/highlight-current-n.nvim'
  use {
    'karb94/neoscroll.nvim',
    config = function ()
      require('neoscroll').setup()
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function ()
      require('fidget').setup()
    end
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require'lualine'.setup({
        options = {
          theme = "catppuccin",
          -- theme = 'auto',
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
    end
  }

  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function ()
      require('catppuccin').setup({
        transparent_background = true,
        term_colors = true
      })
      vim.cmd("colorscheme catppuccin")
    end

  })


  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
      tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      enable_backwards = true, -- well ...
      completion = true, -- if the tabkey is used in a completion pum
      tabouts = {
        {open = "'", close = "'"},
        {open = '"', close = '"'},
        {open = '`', close = '`'},
        {open = '(', close = ')'},
        {open = '[', close = ']'},
        {open = '{', close = '}'}
      },
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = {} -- tabout will ignore these filetypes
  }
    end,
    wants = {'nvim-treesitter'}, -- or require if not used so far
    -- after = {'completion-nvim'} -- if a completion plugin is using tabs load it before
  }
end)
