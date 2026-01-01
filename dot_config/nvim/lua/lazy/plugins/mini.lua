return {
  {
    "rafamadriz/friendly-snippets",
    enabled = true,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    enabled = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
      require("mini.statusline").setup({
        use_icons = true
      })

      require("mini.ai").setup({
        custom_textobjects = {
          f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          F = require("mini.ai").gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),
          o = require("mini.ai").gen_spec.treesitter({
            a = { "@loop.outer", "@conditional.outer" },
            i = { "@loop.inner", "@conditional.inner" },
          }),
          c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          C = require("mini.ai").gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
          s = require("mini.ai").gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.rhs" }),
          S = require("mini.ai").gen_spec.treesitter({ a = "@assignment.inner", i = "@assignment.lhs" }),
        },
        mappings = {
          goto_left = "ga",
          goto_right = "gA"
        },
        n_lines = 100,
      })

      require("mini.comment").setup({})
      require("mini.pairs").setup({})
      require("mini.move").setup({})
      require("mini.misc").setup({})
      require("mini.operators").setup({})
      require("mini.splitjoin").setup({})
      require("mini.surround").setup({
        n_lines = 100,
        serch_method = "cover"
      })

      local gen_loader = require("mini.snippets").gen_loader
      require("mini.snippets").setup({
        snippets = {
          gen_loader.from_lang(),
        },
        mappings = {
          expand = "<C-c>",
          jump_next = "<C-n>",
          jump_prev = "<C-p>",
          stop = "<C-c>"
        }
      })
    end
  }
}
