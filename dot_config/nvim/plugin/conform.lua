local keys = {
  {
    "<leader>cf",
    function()
      require("conform").format({
        timeout_ms = 3000,
        async = true,
      })
    end,
    mode = { "n", "v" },
    desc = "Format",
  },
}

require("utils").map_keys(keys)

require("conform").setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
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
