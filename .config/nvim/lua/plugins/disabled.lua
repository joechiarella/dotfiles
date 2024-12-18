return {
	{
		{ "echasnovski/mini.pairs", enabled = false },
	},
	-- {
	-- 	{ "lukas-reineke/indent-blankline.nvim", enabled = false },
	-- },
	-- {
	-- 	enabled = false,
	-- 	"echasnovski/mini.indentscope",
	-- 	config = function(_, opts)
	-- 		require("mini.indentscope").setup(opts)
	--
	-- 		-- Disable for certain filetypes
	-- 		vim.api.nvim_create_autocmd({ "FileType" }, {
	-- 			desc = "Disable indentscope for certain filetypes",
	-- 			callback = function()
	-- 				local ignore_filetypes = {
	-- 					"aerial",
	-- 					"dashboard",
	-- 					"help",
	-- 					"lazy",
	-- 					"leetcode.nvim",
	-- 					"mason",
	-- 					"neo-tree",
	-- 					"NvimTree",
	-- 					"neogitstatus",
	-- 					"notify",
	-- 					"startify",
	-- 					"toggleterm",
	-- 					"Trouble",
	-- 					"neoterm",
	-- 				}
	-- 				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
	-- 					vim.b.miniindentscope_disable = true
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	{
		"folke/flash.nvim",
		enabled = false,
		keys = {
			{ "/", mode = { "n", "x", "o" }, false },
		},
	},
}
