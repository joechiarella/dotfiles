local Util = require("lazyvim.util")
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fr", false },
    { "<leader>fR", false },
    { "<leader>fo", Util.telescope("oldfiles", { only_cwd = true }), desc = "Recent" },
  },
}
