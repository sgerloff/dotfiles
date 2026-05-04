vim.loader.enable()

require("options")
require("keymaps")
require("autocmds")
require("usercmds")

-- PackChanged hooks (must be defined BEFORE vim.pack.add)
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
    if name == "jupynium.nvim" and (kind == "install" or kind == "update") then
      local dir = vim.fn.stdpath("data") .. "/site/pack/nvim/opt/jupynium.nvim"
      vim.fn.system("cd " .. dir .. " && uv pip install . --python=$HOME/.local/share/jupynium/bin/python")
    end
  end,
})

-- Install and load all plugins
vim.pack.add({
  { src = "https://github.com/catppuccin/nvim",  name = "catppuccin" },
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/okuuva/auto-save.nvim",
  "https://github.com/OXY2DEV/helpview.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/Vigemus/iron.nvim",
  "https://github.com/kiyoon/jupynium.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/jbyuki/one-small-step-for-vimkind",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
})

-- Initialize Snacks global (required before plugin/ files use Snacks.keymap)
require("snacks")

-- Enable LSP servers (per-server config in after/lsp/)
vim.lsp.enable({ "pyrefly", "ruff", "lua_ls", "bashls", "harper_ls" })
