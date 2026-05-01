return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    enabled = true,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" }
    },
    build = ":TSUpdate",
    config = function()
      local TS = require("nvim-treesitter")
      TS.setup({})
    end,
  },
}
