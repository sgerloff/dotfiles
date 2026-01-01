return {
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    version = "*",
    keys = require("config/keymaps").LazyPluginKeys["mrjones2014/smart-splits.nvim"],
    opts = {
      at_edge = "wrap",
    }
  }
}
