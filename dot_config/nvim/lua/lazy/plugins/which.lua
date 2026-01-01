return {
  {
    "folke/which-key.nvim",
    version = "*",
    enabled = true,
    event = "VeryLazy",
    opts = {
      preset = "modern"
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)"
      }
    },
    dependencies = {
      {"nvim-tree/nvim-web-devicons", version="^0.100"}
    }
  }
}
