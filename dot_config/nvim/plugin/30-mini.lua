-- mini.nvim: statusline, ai, comment, icons, pairs, move, operators, splitjoin, surround, snippets

require("mini.statusline").setup({
  use_icons = true,
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

      local recording = vim.fn.reg_recording()
      local macro     = recording ~= "" and ("Recording @" .. recording) or ""

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                    strings = { mode } },
        { hl = "MiniStatuslineDevinfo",    strings = { git, diff, diagnostics, lsp } },
        "%<",
        { hl = "MiniStatuslineFilename",   strings = { filename } },
        "%=",
        { hl = "ErrorMsg",                 strings = { macro } },
        { hl = "MiniStatuslineFileinfo",   strings = { fileinfo } },
        { hl = mode_hl,                    strings = { search, location } },
      })
    end,
    inactive = nil,
  },
})

require("mini.ai").setup({
  custom_textobjects = {
    k = require("mini.ai").gen_spec.treesitter({ a = "@value.outer", i = "@value.inner" }),
    f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    F = require("mini.ai").gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),
    o = require("mini.ai").gen_spec.treesitter({
      a = { "@loop.outer", "@conditional.outer" },
      i = { "@loop.inner", "@conditional.inner" },
    }),
    c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    C = require("mini.ai").gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    v = require("mini.ai").gen_spec.treesitter({ a = "@assignment.lhs", i = "@assignment.rhs" }),
  },
  mappings = {
    goto_left = "ga",
    goto_right = "gA",
  },
  n_lines = 100,
})

require("mini.comment").setup({})
require("mini.icons").setup({})
require("mini.pairs").setup({})
require("mini.move").setup({})
require("mini.misc").setup({})
require("mini.notify").setup({})
require("mini.operators").setup({})
require("mini.splitjoin").setup({})
require("mini.surround").setup({
  n_lines = 100,
  search_method = "cover",
})

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
  snippets = {
    gen_loader.from_lang(),
    gen_loader.from_file("~/.config/my_snippets/python.json"),
  },
  mappings = {
    expand = "<C-s>",
    jump_next = "<C-A-l>",
    jump_prev = "<C-A-h>",
    stop = "<C-s>",
  },
})

-- Stop snippet session when leaving to normal mode
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniSnippetsSessionStart",
  callback = function()
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*:n",
      once = true,
      callback = function()
        while MiniSnippets.session.get() do
          MiniSnippets.session.stop()
        end
      end,
    })
  end,
})
