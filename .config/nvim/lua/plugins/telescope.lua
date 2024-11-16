return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>fr", false },
			{ "<leader>fR", false },
			{ "<leader>fo", LazyVim.pick("oldfiles", { only_cwd = true }), desc = "Recent" },
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<space>fz",
				":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				desc = "File Browser",
			},
		},
	},
}
