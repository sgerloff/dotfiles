return {
  {
    "theHamsta/nvim-dap-virtual-text",
    enabled = true,
    opts = {}
  },
  {
    "nvim-neotest/nvim-nio",
    enabled = true,
    version = "^1.10.1"
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = true,
    version = "^2.4.0",
    dependencies = {
      "mason.nvim"
    },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {
        python = function() end,
      },
      ensure_installed = {
        "debugpy",
      }
    },
    config = function()
      -- handled in nvim-dap
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = true,
    version = "^4.0.0",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    opts = {
      layouts = {
        {
          elements = {
            {
              id ="scopes",
              size = 0.2
            },
            {
              id ="watches",
              size = 0.2
            },
            {
              id = "console",
              size = 0.4
            },
            {
              id ="stacks",
              size = 0.2
            },
          },
          position = "bottom",
          size = 15
        },
      }
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    enabled = true,
    config = function()
      -- handled in nvim-dap
    end
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    version = "^0.9.0",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
      "jbyuki/one-small-step-for-vimkind",
    },
    keys = function()
      return require("config/keymaps").LazyPluginKeys["mfussenegger/nvim-dap"]
    end,
    config = function()
      require("mason-nvim-dap").setup()

      local dap_python = require("dap-python")
      dap_python.setup("uv")
      dap_python.test_runner = "pytest"

      local dap = require("dap")

      -- LUA
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance"
        }
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Pytest",
        module = "pytest",
        justMyCode = false,
        subProcess = true,
        console = "integratedTerminal",
        args = function()
          local input = vim.fn.input("pytest ")
          return vim.fn.split(input, " ")
        end,
      })

      -- Python Terminal
      -- dap.adapters.python_terminal = dap.adapters.python
      --
      --
      -- local pt_configs = dap.configurations.python_terminal or {}
      -- dap.configurations.python_terminal = pt_configs
      -- table.insert(pt_configs, {
      --   {
      --
      --   }
      -- })

      -- MISC
    end
  },
}
