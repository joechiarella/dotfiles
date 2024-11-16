return {
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			return {
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
				sections = {
					lualine_a = {
						"mode",
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							-- color = { fg = "#222222" },
						},
					},
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			}
		end,
	},
}
