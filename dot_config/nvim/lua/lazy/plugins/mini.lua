local keymaps = require("lazy.config.keymaps")
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
    keys = keymaps.LazyPluginKeys["echasnovski/mini.nvim"],
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        content = {
          active = function()
            -- H.use_icons         = H.get_config().use_icons
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 40 })
            local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
            -- H.use_icons         = nil

            -- New section to indicate macro recording:
            local recording     = vim.fn.reg_recording()
            local macro         = recording ~= "" and ("Recording @" .. recording) or ""

            -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
            -- correct padding with spaces between groups (accounts for 'missing'
            -- sections, etc.)
            return MiniStatusline.combine_groups({
              { hl = mode_hl,                 strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'ErrorMsg',               strings = { macro } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl,                  strings = { search, location } },
            })
          end,
          inactive = nil,
        }
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
      require("mini.diff").setup({ view = { style = "number" } })
      require("mini.git").setup({}) -- possibly needed for diff to work better?
      require("mini.icons").setup({})
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
