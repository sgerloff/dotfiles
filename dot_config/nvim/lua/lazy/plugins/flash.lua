local keymaps = require("lazy.config.keymaps")
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        mode = "exact"
      }
    },
    keys = keymaps.LazyPluginKeys["folke/flash.nvim"]
  }
}
