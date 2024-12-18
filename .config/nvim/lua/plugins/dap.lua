return {
	{
		enabled = false,
		"mfussenegger/nvim-dap",
		opts = {
			adapters = {
				mix_task = {
					type = "executable",
					command = "/Users/joe/.lsp/elixir-ls/debug_adapter.sh", -- debug_adapter.bat for windows
					args = {},
				},
			},
		},
	},
	{
		enabled = false,
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = false,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
			},
		},
	},
}
