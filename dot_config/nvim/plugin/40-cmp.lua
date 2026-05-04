require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    ["<C-b>"] = { "scroll_documentation_down", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-l>"] = { "select_and_accept", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },

  },

  completion = {
    list = { selection = { preselect = true, auto_insert = true } },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
  },

  snippets = { preset = "mini_snippets" },

  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },

  signature = { enabled = false },

  fuzzy = { implementation = "prefer_rust_with_warning" },
})
