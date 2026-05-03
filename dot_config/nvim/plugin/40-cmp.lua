local cmp = require("cmp")
local defaults = require("cmp.config.default")()

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  preselect = cmp.PreselectMode.Item,
  mapping = cmp.mapping.preset.insert({
    ["<C-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-b>"] = cmp.mapping.scroll_docs(4),
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-l>"] = cmp.mapping.confirm({ select = true }),
    ["<C-CR>"] = function(fallback)
      cmp.abort()
      fallback()
    end,
  }),
  snippet = {
    expand = function(args)
      local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      insert({ body = args.body })
      cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "mini_snippets", use_item_cache = false },
  }, {
    { name = "buffer" },
  }),
  formatting = defaults.formatting,
  experimental = {
    ghost_text = true,
  },
  sorting = defaults.sorting,
})
