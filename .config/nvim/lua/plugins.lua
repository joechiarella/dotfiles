vim.cmd([[packadd packer.nvim]])

vim.g["test#runner_commands"] = { "ExUnit" }
vim.g["test#ruby#use_binstubs"] = 0
vim.g.dbs = {
	melody_dev = "postgres://postgres:@localhost:5432/melody_development",
}

vim.g.db = "postgres://postgres:@localhost:5432/melody_development"

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 3000)]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("takac/vim-hardtime")
	use("tpope/vim-sensible")
	use("mrjones2014/legendary.nvim")
	use("stevearc/dressing.nvim")
	use("kassio/neoterm")

	use("tpope/vim-dadbod")
	--use("kristijanhusak/vim-dadbod-ui")

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup({})
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	})

	use("mrjones2014/smart-splits.nvim")
	use("vim-test/vim-test")

	--use({
	--"nvim-neotest/neotest",
	--requires = {
	--"nvim-lua/plenary.nvim",
	--"nvim-treesitter/nvim-treesitter",
	--"antoinemadec/FixCursorHold.nvim",
	--"olimorris/neotest-rspec",
	--},
	--})

	--require("neotest").setup({
	--adapters = {
	--require("neotest-rspec"),
	--},
	--})

	--use({
	--"rcarriga/vim-ultest",
	--requires = { "vim-test/vim-test" },
	--opt = true,
	--keys = { "<leader>t" },
	--cmd = {
	--"TestNearest",
	--"TestFile",
	--"TestSuite",
	--"TestLast",
	--"TestVisit",
	--"Ultest",
	--"UltestNearest",
	--"UltestDebug",
	--"UltestLast",
	--"UltestSummary",
	--},
	--module = "ultest",
	--run = ":UpdateRemotePlugins",
	--})

	--use({
	--"mickael-menu/zk-nvim",
	--config = function()
	--require("zk").setup({
	--picker = "telescope",
	--})
	--end,
	--})

	use({
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("gitlinker").setup()
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	use("preservim/nerdcommenter")

	use("ellisonleao/glow.nvim")

	-- Load custom tree-sitter grammar for org filetype
	require("orgmode").setup_ts_grammar()

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
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
					--			additional_vim_regex_highlighting = false,
					--disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
					--additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_innremental = "grn",
						scope_incremental = "grc",
						node_demremental = "grm",
					},
				},
				indent = {
					enable = true,
				},
			})
		end,
	})

	require("orgmode").setup({
		org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
		org_default_notes_file = "~/Dropbox/org/refile.org",
		win_split_mode = "auto",
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local sources = {
				-- elixir
				--null_ls.builtins.formatting.mix,
				null_ls.builtins.diagnostics.credo,

				-- lua
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.luacheck,

				-- js
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint,

				-- ruby
				--null_ls.builtins.formatting.rubocop,
				null_ls.builtins.diagnostics.rubocop,

				-- xml
				null_ls.builtins.formatting.xmllint,

				-- sql
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres", "--exclude-rules", "L022,L044,L031" }, -- change to your dialect
				}),

				--null_ls.builtins.formatting.sql_formatter,
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres", "--exclude-rules", "L022,L044,L031" }, -- change to your dialect
				}),
			}

			null_ls.setup({
				sources = sources,
				--on_attach = function(client)
				--if client.resolved_capabilities.document_formatting then
				--vim.cmd([[
				--augroup LspFormatting
				--autocmd! * <buffer>
				--autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 10000)
				--augroup END
				--]])
				--end
				--end,
			})
		end,
	})
	use("nvim-treesitter/playground")

	use("ThePrimeagen/vim-be-good")
	use("ggandor/lightspeed.nvim")
	use("francoiscabrol/ranger.vim")
	use("rbgrouleff/bclose.vim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
						n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
					},
					path_display = { truncate = 3 },
					layout_strategy = "horizontal",
					layout_config = { height = 0.95, width = 0.95 },
					dynamic_preview_title = true,
					--  file_previewer = require'telescope.previewers'.cat.new,
				},
				extensions = {
					frecency = {
						show_scores = true,
						show_unindexed = true,
						default_workspace = "CWD",
					},
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
							},
						},
					},
				},
			})
			require("telescope").load_extension("fzy_native")
			require("telescope").load_extension("file_browser")
	require("telescope").load_extension("neoclip")
		end,
	})

	use("nvim-telescope/telescope-fzy-native.nvim")

	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			-- you'll need at least one of these
			{ "nvim-telescope/telescope.nvim" },
			-- {'ibhagwan/fzf-lua'},
		},
		config = function()
			require("neoclip").setup()
		end,
	})

	require("telescope").load_extension("neoclip")

	use({
		"neovim/nvim-lspconfig",
	})

	local on_attach = function(client, _)
		-- Mappings.
		local opts = { noremap = true, silent = true }
		require("legendary").bind_keymaps({
			{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", description = "LSP Declaration", opts },
			{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", description = "LSP Defintion", opts },
			{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", description = "LSP Hover", opts },
			{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", description = "LSP Impl", opts },
			-- your keymaps here
		})
		-- See `:help vim.lsp.*` for documentation on any of the below functions
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
		--client.resolved_capabilities.document_formatting = false
		--client.resolved_capabilities.document_range_formatting = false
	end
	use({ "ms-jpq/coq_nvim" })
	use({ "ms-jpq/coq.artifacts" })

	local coq = require("coq")
	-- vim.lsp.set_log_level("debug")
	require("lspconfig").solargraph.setup(coq.lsp_ensure_capabilities({
		cmd = { "solargraph", "stdio" },
		--cmd = { "bundle", "exec", "solargraph", "stdio" },
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = on_attach,
	}))
	require("lspconfig").elixirls.setup(coq.lsp_ensure_capabilities({
		-- Unix
		on_attach = on_attach,
		settings = {
			elixirLS = {
				dialyzerEnabled = false,
			},
		},
		cmd = { "/Users/joechiarella/.lsp/elixir-ls/language_server.sh" },
	}))

	use("rktjmp/highlight-current-n.nvim")
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	--  use {
	--    'pwntester/octo.nvim',
	--    requires = {
	--      'nvim-lua/plenary.nvim',
	--      'nvim-telescope/telescope.nvim',
	--      'kyazdani42/nvim-web-devicons',
	--    },
	--    config = function ()
	--      require"octo".setup()
	--    end
	--  }

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
					theme = "catppuccin",
					-- theme = 'auto',
					icons_enabled = true,
					section_separators = { left = "", right = "" },
					--section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { {
						"filename",
						path = 1,
					} },
					lualine_x = {
						{
							"filetype",
							icons_enabled = false,
						},
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				--tabline = {
				--lualine_a = {},
				--lualine_b = { "buffers" },
				--lualine_c = {},
				--lualine_x = {},
				--lualine_y = {},
				--lualine_z = { "branch" },
				--},
			})
		end,
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
				term_colors = false,
			})
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
			vim.cmd("colorscheme catppuccin")
		end,
	})
	local wk = require("which-key")
	wk.register({
		["<leader>"] = {
			f = {
				name = "Telescope",
				f = { require("telescope.builtin").find_files, "Find Files" },
				g = { require("telescope.builtin").live_grep, "Live Grep" },
				b = { require("telescope.builtin").buffers, "Buffers" },
				h = { require("telescope.builtin").help_tags, "Help Tags" },
				r = { require("telescope.builtin").lsp_references, "LSP References" },
				s = { require("telescope.builtin").lsp_document_symbols, "LSP Document Symbols" },
				m = { require("telescope.builtin").marks, "Marks" },
				j = { require("telescope.builtin").jumplist, "Jumplist" },
				i = { require("telescope.builtin").lsp_implementations, "LSP Implementations" },
				d = { require("telescope.builtin").lsp_definitions, "LSP Definitions" },
				p = { require("telescope.builtin").lsp_dynamic_workspace_symbols, "LSP Workspace Symbols" },
				t = { require("telescope.builtin").treesitter, "Treesitter" },
				l = { require("telescope").extensions.file_browser.file_browser, "File Browser" },
				z = {
					function()
						require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" })
					end,
					"File Browser (CWD)",
				},
				o = {
					function()
						require("telescope.builtin").oldfiles({ only_cwd = true })
					end,
					"Recent Files",
				},
				c = { "<cmd>Telescope neoclip unnamed extra=star,plus<CR>", "Neoclip" },
			},
			x = {
				name = "Trouble",
				x = { "<cmd>TroubleToggle<CR>", "Open Trouble" },
				w = { "<cmd>Trouble workspace_diagnostics<cr>", "Trouble Workspace Diagnostics" },
				d = { "<cmd>Trouble document_diagnostics<cr>", "Trouble Document Diagnostics" },
				l = { "<cmd>Trouble loclist<cr>", "Trouble Loclist" },
				q = { "<cmd>Trouble quickfix<cr>", "Trouble Quickfix" },
			},
			t = {
				name = "Test",
				S = { "<cmd>UltestSummary<cr>", "Summary" },
				a = { "<cmd>Ultest<cr>", "All" },
				d = { "<cmd>UltestDebug<cr>", "Debug" },
				f = { "<cmd>TestFile<cr>", "File" },
				l = { "<cmd>TestLast<cr>", "Last" },
				n = { "<cmd>TestNearest<cr>", "Nearest" },
				o = { "<cmd>UltestOutput<cr>", "Output" },
				s = { "<cmd>TestSuite<cr>", "Suite" },
				v = { "<cmd>TestVisit<cr>", "Visit" },
        t = { "<cmd>Tredo<cr>", "Redo" },
			},
			--d = {
			--name = "DadBod",
			--b = { "<cmd>db#op_exec()", "Execute" },
			--},
			e = { vim.diagnostic.open_float, "LSP Open Diagnostic" },
			q = { vim.diagnostic.setloclist, "LSP Set Loc List" },
			y = { "<cmd>let @*=expand('%:p')<CR>", "Copy filename" },
			Y = { "<cmd>let @*=(expand('%:p') . ':' . line('.'))<CR>", "Copy filename:line" },
			r = { "<cmd>Ranger<CR>", "Open Ranger" },
			h = { "<cmd>HardTimeToggle<CR>", "Toggle HardTime" },
		},
		["[d"] = { vim.diagnostic.goto_prev, "LSP Prev Diagnostic" },
		["]d"] = { vim.diagnostic.goto_next, "LSP Next Diagnostic" },
	})

	require("legendary").setup({})

	-- moving between splits
	vim.keymap.set("n", "<C-h>", require("smart-splits").resize_left)
	vim.keymap.set("n", "<C-j>", require("smart-splits").resize_down)
	vim.keymap.set("n", "<C-k>", require("smart-splits").resize_up)
	vim.keymap.set("n", "<C-l>", require("smart-splits").resize_right)
	-- moving between splits
	vim.keymap.set("n", "<C-A-h>", require("smart-splits").move_cursor_left)
	vim.keymap.set("n", "<C-A-j>", require("smart-splits").move_cursor_down)
	vim.keymap.set("n", "<C-A-k>", require("smart-splits").move_cursor_up)
	vim.keymap.set("n", "<C-A-l>", require("smart-splits").move_cursor_right)
end)
