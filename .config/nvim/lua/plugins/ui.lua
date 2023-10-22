return {
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"shortcuts/no-neck-pain.nvim",
		lazy = false,
		opts = {
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
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"projekt0n/circles.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			lsp = true,
		},
	},

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
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
      }
    end

  }

}
