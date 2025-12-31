return {
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    version = "^2",
    keys = require("config/keymaps").LazyPluginKeys["mrjones2014/smart-splits.nvim"],
    opts = {
      at_edge = "wrap",
    }
  }
}
