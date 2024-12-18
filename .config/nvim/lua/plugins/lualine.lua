return {
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local icons = LazyVim.config.icons

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
					-- lualine_x = { "encoding", "fileformat", "filetype" },

					lualine_x = {
						Snacks.profiler.status(),
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = function() return { fg = Snacks.util.color("Statement") } end,
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
        -- stylua: ignore
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function() return { fg = Snacks.util.color("Special") } end,
        },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					},
					lualine_z = {
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
}
