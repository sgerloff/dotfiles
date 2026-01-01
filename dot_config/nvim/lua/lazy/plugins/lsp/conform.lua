local keymaps = require("lazy.config.keymaps")

return {
  {
    "stevearc/conform.nvim",
    version = "*",
    enabled = true,
    keys = keymaps.LazyPluginKeys["stevearc/conform.nvim"],
    config = function()
      require("conform").setup({
        default_format_opts = {
          timeout_ms = 3000,
          async = false,           -- not recommended to change
          quiet = false,           -- not recommended to change
          lsp_format = "fallback", -- not recommended to change
        },
        formatters_by_ft = {
          yaml = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
          toml = { "prettier" },
          sh = { "shfmt" },
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = true,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, null_ls.builtins.formatting.prettier)
      table.insert(opts.sources, null_ls.builtins.formatting.shfmt)
    end,
  },
}
