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
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

vim.api.nvim_create_user_command(
	"DiffCommitLine",
	"lua require('telescope').extensions.advanced_git_search.diff_commit_line()",
	{ range = true }
)

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	--use("takac/vim-hardtime")
	--use("tpope/vim-sensible")
	use("mrjones2014/legendary.nvim")
	use("mrjones2014/smart-splits.nvim")
	use("stevearc/dressing.nvim")
	use("kassio/neoterm")
	use("eandrju/cellular-automaton.nvim")

	--use("github/copilot.vim")
	--use({
	--"zbirenbaum/copilot.lua",
	--cmd = "Copilot",
	--event = "InsertEnter",
	--config = function()
	--require("copilot").setup({
	--suggestion = { enabled = false },
	--panel = { enabled = false },
	--})
	--end,
	--})

	--use({
	--"zbirenbaum/copilot-cmp",
	--after = { "copilot.lua" },
	--config = function()
	--require("copilot_cmp").setup()
	--end,
	--})
	use({
		"shortcuts/no-neck-pain.nvim",
		tag = "*",
		config = function()
			require("no-neck-pain").setup({
				autocmds = {
					-- When `true`, enables the plugin when you start Neovim.
					-- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
					-- The command is cleaned once it has successfuly ran once.
					--- @type boolean
					enableOnVimEnter = true,
					-- When `true`, enables the plugin when you enter a new Tab.
					-- note: it does not trigger if you come back to an existing tab, to prevent unwanted interfer with user's decisions.
					--- @type boolean
					enableOnTabEnter = false,
					-- When `true`, reloads the plugin configuration after a colorscheme change.
					--- @type boolean
					reloadOnColorSchemeChange = false,
				},
			})
		end,
	})

	use({
		"aaronhallaert/advanced-git-search.nvim",
		config = function()
			require("telescope").load_extension("advanced_git_search")
		end,
		requires = {
			"nvim-telescope/telescope.nvim",
			-- to show diff splits and open commits in browser
			"tpope/vim-fugitive",
		},
	})

	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				icons = {
					Class = "",
					Constructor = "",
					Enum = "",
					Function = "",
					Interface = "",
					Module = "",
					Method = "",
					Struct = "",
				},
				nerd_font = true,
				layout = {
					placement = "edge",
				},
				attach_mode = "global",
			})
		end,
	})

	use({
		"projekt0n/circles.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("circles").setup()
		end,
	})

	use("epwalsh/obsidian.nvim")
	require("obsidian").setup({
		dir = "~/Documents/Obsidian/Salesloft",
		completion = {
			nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
		},
	})

	--vim.api.nvim_create_augroup("OnVimEnter", { clear = true })
	--vim.api.nvim_create_autocmd({ "VimEnter" }, {
	--group = "OnVimEnter",
	--pattern = "*",
	--callback = function()
	--vim.schedule(function()
	--require("no-neck-pain").enable()
	--end)
	--end,
	--})

	use("tpope/vim-dadbod")
	--use("kristijanhusak/vim-dadbod-ui")
	use({
		"tamton-aquib/duck.nvim",
		config = function()
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch()
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
		end,
	})

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

	--use({
	--"nvim-orgmode/orgmode",
	--config = function()
	--require("orgmode").setup({})
	--end,
	--})

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
			require("gitlinker").setup({
				mappings = nil,
			})
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
	--require("orgmode").setup_ts_grammar()

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

	--require("orgmode").setup({
	--org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
	--org_default_notes_file = "~/Dropbox/org/refile.org",
	--win_split_mode = "auto",
	--})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local sources = {
				-- git
				null_ls.builtins.code_actions.gitsigns,

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
				--null_ls.builtins.diagnostics.rubocop,

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
	--use("nvim-treesitter/playground")

	--use("ThePrimeagen/vim-be-good")
	--use("ggandor/lightspeed.nvim")
	use("ggandor/leap.nvim")
	require("leap").add_default_mappings()
	use("rbgrouleff/bclose.vim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-live-grep-args.nvim" } },
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
			require("telescope").load_extension("live_grep_args")
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
		require("legendary").keymaps({
			{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", description = "LSP Declaration", opts },
			{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", description = "LSP Defintion", opts },
			{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", description = "LSP Hover", opts },
			{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", description = "LSP Impl", opts },
		})
	end

	-- COMPLETION
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	--use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	--use("hrsh7th/cmp-vsnip")
	--use("hrsh7th/vim-vsnip")

	use({ "L3MON4D3/LuaSnip" })

	local cmp = require("cmp")
	local luasnip = require("luasnip")

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			-- Copilot Source
			--{ name = "copilot", group_index = 2 },
			{ name = "nvim_lsp" },
			--{ name = "vsnip" }, -- For vsnip users.
			{ name = "luasnip" }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = "buffer" },
		}),
	})

	use({ "saadparwaiz1/cmp_luasnip" })

	use("rafamadriz/friendly-snippets")
	require("luasnip").filetype_extend("ruby", { "rails" })

	require("luasnip.loaders.from_vscode").lazy_load()

	--cmp.setup.cmdline({ "/", "?" }, {
	--mapping = cmp.mapping.preset.cmdline(),
	--sources = {
	--{ name = "buffer" },
	--},
	--})

	--use({ "ms-jpq/coq_nvim" })
	--use({ "ms-jpq/coq.artifacts" })

	--local coq = require("coq")
	-- vim.lsp.set_log_level("debug")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("lspconfig").solargraph.setup({
		--cmd = { "solargraph", "stdio" },
		cmd = { "bundle", "exec", "solargraph", "stdio" },
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = on_attach,
		capabilities = capabilities,
		solargraph = {
			diagnostics = true,
		},
	})
	require("lspconfig").elixirls.setup({
		-- Unix
		on_attach = on_attach,
		settings = {
			elixirLS = {
				dialyzerEnabled = false,
			},
		},
		cmd = { "/Users/joechiarella/.lsp/elixir-ls/language_server.sh" },
		capabilities = capabilities,
	})
	require("lspconfig").tsserver.setup({
		on_attach = function(client)
			on_attach(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		capabilities = capabilities,
	})

	use("rktjmp/highlight-current-n.nvim")

	use("j-hui/fidget.nvim")

	require("fidget").setup({})

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
		"catppuccin/nvim",
		as = "catppuccin",
	})
	require("catppuccin").setup({
		transparent_background = false,
		term_colors = false,
	})
	vim.cmd.colorscheme("catppuccin-mocha")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	require("lualine").setup({
		options = {
			globalstatus = true,
			theme = "catppuccin",
			icons_enabled = true,
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					path = 1,
				},
				"aerial",
			},
			lualine_x = {
				{
					"filetype",
					icons_enabled = true,
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},

		inactive_winbar = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	})

	local wk = require("which-key")
	wk.register({
		["<leader>"] = {
			f = {
				name = "Telescope",
				f = { require("telescope.builtin").find_files, "Find Files" },
				g = { require("telescope").extensions.live_grep_args.live_grep_args, "Live Grep" },
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
			g = {
				name = "Git",
				y = {
					function()
						require("gitlinker").get_buf_range_url("n")
					end,
					"Permalink to line",
				},
				b = { require("telescope").extensions.advanced_git_search.diff_branch_file, "Browse Branches" },
				l = { require("telescope").extensions.advanced_git_search.diff_commit_line, "View commits for line" },
				f = { require("telescope").extensions.advanced_git_search.diff_commit_file, "View commits for file" },
				c = {
					require("telescope").extensions.advanced_git_search.search_log_content,
					"Search Log Content for Repo",
				},
				s = {
					require("telescope").extensions.advanced_git_search.search_log_content_file,
					"Search Log Content for File",
				},
			},
			l = {
				name = "LSP",
				a = { vim.lsp.buf.code_action, "Code Action" },
				k = { vim.lsp.buf.signature_help, "Signature Help" },
				d = { vim.lsp.buf.type_definition, "Type Definition" },
				r = { vim.lsp.buf.rename, "Rename" },
				e = { vim.diagnostic.open_float, "LSP Open Diagnostic" },
				q = { vim.diagnostic.setloclist, "LSP Set Loc List" },
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
				f = { "<cmd>TestFile<cr>", "File" },
				l = { "<cmd>TestLast<cr>", "Last" },
				n = { "<cmd>TestNearest<cr>", "Nearest" },
				s = { "<cmd>TestSuite<cr>", "Suite" },
				v = { "<cmd>TestVisit<cr>", "Visit" },
				t = { "<cmd>Tredo<cr>", "Redo" },
			},
			a = {
				name = "Automaton",
				a = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it rain" },
				b = { "<cmd>CellularAutomaton game_of_life<CR>", "Game of life" },
			},
			o = { "<cmd>AerialToggle!<CR>", "Open Aerial" },
			--d = {
			--name = "DadBod",
			--b = { "<cmd>db#op_exec()", "Execute" },
			--},
			y = { "<cmd>let @*=expand('%:p')<CR>", "Copy filename" },
			Y = { "<cmd>let @*=(expand('%:p') . ':' . line('.'))<CR>", "Copy filename:line" },
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
