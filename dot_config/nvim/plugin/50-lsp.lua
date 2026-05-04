local utils = require("utils")

-- LSP keymaps (auto-applied to buffers with an LSP client via Snacks.keymap)
local keys = {
  { "<leader>cl", "<cmd>LspInfo<cr>",                                 desc = "Lsp Info",                   lsp = {} },
  { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover",                      lsp = {} },
  { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",             lsp = {} },
  { "<c-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", lsp = {} },
  { "<leader>ca", vim.lsp.buf.code_action,                            mode = { "n", "v" }, desc = "Code Action", lsp = {} },
  { "<leader>cc", vim.lsp.codelens.run,                               mode = { "n", "v" }, desc = "Run Codelens", lsp = {} },
  { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display Codelens", lsp = {} },
  { "<leader>cr", vim.lsp.buf.rename,                                 desc = "Rename",                     lsp = {} },
}

utils.map_keys(keys)

-- Advertise blink.cmp capabilities to all LSP servers
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

-- Mason: ensure binaries are installed
require("mason").setup({})

local ensure_installed = {
  "lua-language-server",
  "pyrefly",
  "ruff",
  "bash-language-server",
  "harper-ls",
  "prettier",
  "shfmt",
}

local registry = require("mason-registry")
registry.refresh(function()
  for _, name in ipairs(ensure_installed) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)

-- Lazydev: Lua development support
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
