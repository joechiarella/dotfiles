return {

	"kassio/neoterm",
	{ "eandrju/cellular-automaton.nvim", lazy = true },

	{
		"vim-test/vim-test",
		keys = {
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "File" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Last" },
			{ "<leader>tn", "<cmd>TestNearest<cr>", desc = "Nearest" },
			{ "<leader>ts", "<cmd>TestSuite<cr>", desc = "Suite" },
			{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "Visit" },
			{ "<leader>tt", "<cmd>Tredo<cr>", desc = "Redo" },
		},
	},
	{
		"folke/trouble.nvim",
		lazy = true,
	},
	{
		"preservim/nerdcommenter",
		lazy = true,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function()
			local null_ls = require("null-ls")

			return {
				sources = {
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
				},
			}
		end,
	},
	{ "nvim-telescope/telescope-fzy-native.nvim", lazy = true },
	{
		"nvim-telescope/telescope-file-browser.nvim",
		lazy = true,
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	"AckslD/nvim-neoclip.lua",

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
		opts = {
			defaults = {
				mappings = {
					--i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
					--n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
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
		},
		config = function()
			-- require("telescope").load_extension("fzy_native")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("neoclip")
			require("telescope").load_extension("live_grep_args")
		end,
		keys = {
			{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{
				"<leader>fg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				desc = "Grep (root dir)",
			},
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			-- find
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
			--{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
			--{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{
				"<leader>fo",
				":lua require('telescope.builtin').oldfiles({ only_cwd = true })<cr>",
				desc = "Recent Files",
			},
			{
				"<leader>fz",
				":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				desc = "File Browser",
			},
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
			-- search
			{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			--{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			--{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			--{ "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
			--{ "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
			--{ "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
			--{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
			--{ "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
			--{
			--"<leader>ss",
			--Util.telescope("lsp_document_symbols", {
			--symbols = {
			--"Class",
			--"Function",
			--"Method",
			--"Constructor",
			--"Interface",
			--"Module",
			--"Struct",
			--"Trait",
			--"Field",
			--"Property",
			--},
			--}),
			--desc = "Goto Symbol",
			--},
			--{
			--"<leader>sS",
			--Util.telescope("lsp_dynamic_workspace_symbols", {
			--symbols = {
			--"Class",
			--"Function",
			--"Method",
			--"Constructor",
			--"Interface",
			--"Module",
			--"Struct",
			--"Trait",
			--"Field",
			--"Property",
			--},
			--}),
			--desc = "Goto Symbol (Workspace)",
			--},
		},
	},
	{
		"neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "gD", vim.lsp.buf.declaration, desc = "LSP Declaration" },
			{ "gd", vim.lsp.buf.definition, desc = "LSP Defintion" },
			{ "K", vim.lsp.buf.hover, desc = "LSP Hover" },
			{ "gi", vim.lsp.buf.implementation, desc = "LSP Impl" },
		},
		init = function()
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
       vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format()
                end,
            })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					--vim.keymap.set("n", "<space>f", function()
					--vim.lsp.buf.format({ async = true })
					--end, opts)
				end,
			})
		end,
		config = function()
			require("lspconfig").solargraph.setup({
				--cmd = { "solargraph", "stdio" },
				cmd = { "bundle", "exec", "solargraph", "stdio" },
				flags = {
					debounce_text_changes = 150,
				},
				solargraph = {
					diagnostics = true,
				},
			})
			require("lspconfig").elixirls.setup({
				-- Unix
				settings = {
					elixirLS = {
						dialyzerEnabled = false,
					},
				},
				cmd = { "/Users/joechiarella/.lsp/elixir-ls/language_server.sh" },
			})
			require("lspconfig").tsserver.setup({
				--on_attach = function(client)
					--on_attach(client)
					--client.server_capabilities.documentFormattingProvider = false
					--client.server_capabilities.documentRangeFormattingProvider = false
				--end,
			})
		end,
	},
}
