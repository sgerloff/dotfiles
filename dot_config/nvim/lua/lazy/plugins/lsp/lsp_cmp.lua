return {
  "hrsh7th/cmp-nvim-lsp",
  event={"BufReadPre", "BufNewFile"},
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", {capabilities=capabilities})
  end
}
