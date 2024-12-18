return {
	-- {
	-- 	"lewis6991/gitsigns.nvim",
	-- 	opts = {
	-- 		current_line_blame = true,
	-- 		current_line_blame_opts = {
	-- 			virt_text = true,
	-- 			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
	-- 			delay = 1000,
	-- 			ignore_whitespace = false,
	-- 		},
	-- 	},
	-- },
	{
		"ruifm/gitlinker.nvim",
		lazy = true,
		keys = {
			{ "<leader>gy", '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>', desc = "Copy Git URL" },
			{ "<leader>gY", '<cmd>lua require"gitlinker".get_repo_url()<cr>', desc = "Copy Repo URL" },
			{
				"<leader>gB",
				'<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
				desc = "Open Repo in Browser",
			},
		},
		opts = {
			mappings = nil,
		},
	},
}
