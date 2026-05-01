return {
  "kiyoon/jupynium.nvim",
  dependencies = {
    "rcarriga/nvim-notify"
  },
  build = "uv pip install . --python=$HOME/.local/share/jupynium/bin/python",
  keys = require("lazy.config.keymaps").LazyPluginKeys["kiyoon/jupynium.nvim"],
  config = function()
    require("jupynium").setup({
      python_host = vim.fn.expand("$HOME/.local/share/jupynium/bin/python"),
      use_default_keybindings=false,
    })
  end
}
