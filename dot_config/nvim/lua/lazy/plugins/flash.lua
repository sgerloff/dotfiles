local keymaps = require("lazy.config.keymaps")
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        mode = "fuzzy"
      }
    },
    keys = keymaps.LazyPluginKeys["folke/flash.nvim"]
  }
}
