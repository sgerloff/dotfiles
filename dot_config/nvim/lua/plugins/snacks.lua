return {
  {
    "folke/snacks.nvim",
    version = "^2.20.0",
    enabled = true,
    keys = require("config/keymaps").LazyPluginKeys["folke/snacks.nvim"],
    opts = {
      picker = {},
      explorer = {},
      statuscolumn = { enabled = false }
    }
  }
}
