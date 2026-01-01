local keymaps = require("lazy.config.keymaps")
return {
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    version = "*",
    keys = keymaps.LazyPluginKeys["mrjones2014/smart-splits.nvim"],
    opts = {
      at_edge = "wrap",
    }
  }
}
