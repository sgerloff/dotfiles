return {
  {
    "folke/snacks.nvim",
    version = "*",
    enabled = true,
    lazy = false,
    priority = 1000,
    keys = require("config/keymaps").LazyPluginKeys["folke/snacks.nvim"],
    opts = {
      picker = {},
      explorer = {},
      statuscolumn = { enabled = false },
      zen = {
        toggles = {
          dim = false,
        },
        win = {
          width = 160
        },
        show = {
          statusline = true,
          tabline = true
        },
      }
    }
  }
}
