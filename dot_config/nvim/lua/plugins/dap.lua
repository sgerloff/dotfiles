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
    opts = {},
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
      require("dap-python").setup("uv")

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
