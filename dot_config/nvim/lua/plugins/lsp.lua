local M = {}
M.servers = { "lua_ls", "basedpyright", "ruff", "clangd" }
M.server_opts = {
  ["lua_ls"] = {
    settings = {
      Lua = {
        format = {
          defaultConfig = {
            indent_style = "space",
            indent_size = 2
          }
        }
      }
    }
  },
  ["basedpyright"] = {
    on_init = function(client)
      client.config.settings.python = {
        pythonPath = require("config.utils").get_python_path()
      }
    end,
    settings = {}
  },
  ["ruff"] = {
    on_init = function(client)
      client.config.settings.args.interpreter = require("config.utils").get_python_path()
    end,
    settings = {
      args = {}
    }
  },
  ["clangd"] = {
    keys = {
      { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"

      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
        fname
      ) or require("lspconfig.util").find_git_ancestor(fname)
    end,
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,

      completeUnimported = true,
      clangdFileStatus = true,
    },
  }
}


M.keys = require("config/keymaps").LazyPluginKeys["lsp_on_attach"]

function M.on_attach(_, buffer)
  local nmap = function(mode, keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    if not mode then
      mode = "n"
    end

    vim.keymap.set(mode, keys, func, { buffer = buffer, desc = desc })
  end

  for _, key in ipairs(M.keys) do
    nmap(key.mode, key[1], key[2], key.desc)
  end
end

return {
  {
    "williamboman/mason.nvim",
    version = "^1.10.0",
    enabled = true,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.31.0",
    enabled = true,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = M.servers,
        automatic_installation = false
      })
    end
  },
  {
    "folke/lazydev.nvim",
    version = "^1.9.0",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    version = "^8.4.0",
    enabled = "true",
    keys = {
      {
        "<leader>cF",
        function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
        mode = { "n", "v" },
        desc = "Format Injected Langs"
      }
    },
    config = function()
      require("conform").setup({
        default_format_opts = {
          timeout_ms = 3000,
          async = false,           -- not recommended to change
          quiet = false,           -- not recommended to change
          lsp_format = "fallback", -- not recommended to change
        },
        formatters_by_ft = {
        },
        formatters = {
          injected = { options = { ignore_errors = true } }
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    version = "^1.6.0",
    enabled = true,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/lazydev.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "stevearc/conform.nvim" },
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, lsp in ipairs(M.servers) do
        local opts_ = M.server_opts[lsp]
        if not opts_ then
          opts_ = {}
        end
        opts_["on_attach"] = M.on_attach
        opts_["capabilities"] = capabilities
        require("lspconfig")[lsp].setup(opts_)
      end
    end
  },
}
