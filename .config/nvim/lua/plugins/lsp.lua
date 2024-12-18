return {
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				solargraph = {
					mason = false,
					cmd = { "bundle", "exec", "solargraph", "stdio" },
					flags = {
						debounce_text_changes = 150,
					},
					solargraph = {
						diagnostics = true,
					},
				},
				tsserver = {},
				elixirls = {
					mason = false,
					settings = {
						elixirLS = {
							dialyzerEnabled = false,
						},
					},
					cmd = { "/Users/joe/.lsp/elixir-ls/language_server.sh" },
				},
			},
		},
		setup = {
			-- example to setup with typescript.nvim
			-- tsserver = function(_, opts)
			--   require("typescript").setup({ server = opts })
			--   return true
			-- end,
			-- Specify * to use this function as a fallback for any server
			-- ["*"] = function(server, opts) end,
			elixirls = function(_, _)
				return true
			end,
		},
	},
	-- {
	-- 	"elixir-tools/elixir-tools.nvim",
	-- 	version = "*",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	config = function()
	-- 		local elixir = require("elixir")
	-- 		local elixirls = require("elixir.elixirls")
	-- 		local nextls = require("elixir.nextls")
	--
	-- 		elixir.setup({
	-- 			nextls = {
	-- 				enable = true,
	-- 				init_options = {
	-- 					experimental = {
	-- 						completions = {
	-- 							enable = true,
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 			credo = {
	-- 				enable = false,
	-- 			},
	-- 			elixirls = {
	-- 				enable = false,
	-- 				settings = elixirls.settings({
	-- 					dialyzerEnabled = false,
	-- 					enableTestLenses = false,
	-- 				}),
	-- 				on_attach = function(client, bufnr)
	-- 					vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
	-- 					vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
	-- 					vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },
}
