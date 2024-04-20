return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "python-lsp-server",
        "debugpy",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "shfmt",
        "stylua",
        "yaml-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                ruff = {
                  enabled = true,
                  formatEnabled = true,
                },
                pyls_isort = {
                  enabled = true,
                },
                black = {
                  enabled = true,
                },
                rope = {
                  enabled = true,
                },
                pylsp_mypy = {
                  enabled = true,
                },
                jedi_completion = {
                  fuzzy = true,
                },
              },
            },
          },
        },
      },
      setup = {
        -- Disable Pyright from LazyExtras
        pyright = function(_, _)
          return true
        end,
        ruff_lsp = function(_, _)
          return true
        end,
      },
    },
  },
}
