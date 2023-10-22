return {
	{
		"mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
		config = function()
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").resize_right)
			-- moving between splits
			vim.keymap.set("n", "<C-A-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-A-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-A-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-A-l>", require("smart-splits").move_cursor_right)
		end,
	},
	{
		"rktjmp/highlight-current-n.nvim",
		lazy = true,
    config = function() 

      vim.cmd([[
      " ******* highlight-current-n plugin
      nmap n <Plug>(highlight-current-n-n)
      nmap N <Plug>(highlight-current-n-N)

      nmap * *N

      " Some QOL autocommands
      augroup ClearSearchHL
        autocmd!
        " You may only want to see hlsearch /while/ searching, you can automatically
        " toggle hlsearch with the following autocommands
        autocmd CmdlineEnter /,\? set hlsearch
        autocmd CmdlineLeave /,\? set nohlsearch
        " this will apply similar n|N highlighting to the first search result
        " careful with escaping ? in lua, you may need \\?
        autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
      augroup END

      syntax off
        ]])
    end
	},
}
