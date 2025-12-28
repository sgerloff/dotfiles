return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        mode = "fuzzy"
      }
    },
    keys = require("config/keymaps").LazyPluginKeys["folke/flash.nvim"]
  }
}
