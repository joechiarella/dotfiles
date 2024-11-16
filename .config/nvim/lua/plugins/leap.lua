return {
	{
		"ggandor/leap.nvim",
		enabled = true,
		keys = {
			{ "s", mode = { "n", "x" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
}
