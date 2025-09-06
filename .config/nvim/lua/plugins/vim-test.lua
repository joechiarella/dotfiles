return {
	{
		"vim-test/vim-test",
		enabled = false,
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
		"nvim-neotest/neotest",
		commit = "52fca671",
	},
}
