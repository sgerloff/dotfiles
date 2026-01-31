-- bootstrap lazy.nvim, LazyVim and your plugins
require("lazy.config")
require("lazy.lazy")
require("lazy.lsp")

vim.g.disabled_lsps = {
  "basedpyright"
}
