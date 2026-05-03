local utils = require("utils")

local keys = {
  { "<leader>dB", function() utils.dapui_float_element("breakpoints", 0.7) end,                         desc = "Breakpoints (Floating)" },
  { "<leader>dC", function() utils.dapui_float_element("console", 0.7) end,                             desc = "Console (Floating)" },
  { "<leader>dD", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
  { "<leader>dG", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
  { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
  { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
  { "<leader>dR", function() utils.dapui_float_element("repl", 0.7) end,                                desc = "REPL (Floating)" },
  { "<leader>dS", function() require("dap").session() end,                                              desc = "Session" },
  { "<leader>dT", function() require("dap").terminate() end,                                            desc = "Terminate" },
  { "<leader>dW", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
  { "<leader>dd", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
  { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                        mode = { "n", "v" } },
  { "<leader>df", function() utils.dapui_float_element("stacks", 0.7) end,                              desc = "Stacks and Frames (Floating)" },
  { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
  { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
  { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
  { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
  { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
  { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
  { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
  { "<leader>ds", function() utils.dapui_float_element("scopes", 0.7) end,                              desc = "Scopes (Floating)" },
  { "<leader>dt", function() require("dap-python").test_method() end,                                   desc = "Pytest Function" },
  { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
  { "<leader>dw", function() utils.dapui_float_element("watches", 0.7) end,                             desc = "Watches (Floating)" },
}

utils.map_keys(keys)

-- DAP Virtual Text
require("nvim-dap-virtual-text").setup({})

-- DAP UI
local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes",  size = 0.2 },
        { id = "watches", size = 0.2 },
        { id = "console", size = 0.4 },
        { id = "stacks",  size = 0.2 },
      },
      position = "bottom",
      size = 15,
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Mason DAP
require("mason-nvim-dap").setup({
  automatic_installation = true,
  handlers = {
    python = function() end,
  },
  ensure_installed = {
    "debugpy",
  },
})

-- DAP Python
local dap_python = require("dap-python")
dap_python.setup(utils.get_python_path())
dap_python.test_runner = "pytest"

-- Lua DAP
dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
  },
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

-- Extra Python configuration
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
