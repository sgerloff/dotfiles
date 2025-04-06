return {
  {
    "rafamadriz/friendly-snippets",
    enabled = true,
  },
  {
    "echasnovski/mini.nvim",
    version = "^0.15.0",
    enabled = true,
    dependencies = {
      "rafamadriz/friendly-snippets"
    },
    config = function()
      require("mini.statusline").setup({
        use_icons = true
      })

      require("mini.ai").setup({
        custom_textobjects = nil,
        n_lines = 100,
      })

      require("mini.comment").setup({})
      require("mini.pairs").setup({})
      require("mini.move").setup({})
      require("mini.operators").setup({})
      require("mini.splitjoin").setup({})
      require("mini.surround").setup({
        n_lines = 100,
        serch_method = "cover"
      })
      require("mini.jump").setup({})

      local gen_loader = require("mini.snippets").gen_loader
      require("mini.snippets").setup({
        snippets = {
          gen_loader.from_lang(),
        },
      })
    end
  }
}
