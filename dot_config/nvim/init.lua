-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Isolated python environment for neovim plugins
vim.g.python3_host_prog = "~/.local/share/nvim_venv/bin/python"
