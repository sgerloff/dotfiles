local keys = {
  -- Execution
  { "<leader>jj", "<cmd>JupyniumExecuteSelectedCells<cr>",             desc = "Jupynium: Execute Cell" },
  { "<leader>jc", "<cmd>JupyniumClearSelectedCellsOutputs<cr>",        desc = "Jupynium: Clear Cell Outputs" },
  -- Server / Sync
  { "<leader>js", "<cmd>JupyniumStartAndAttachToServer<cr>",           desc = "Jupynium: Start Server + Attach" },
  { "<leader>ja", "<cmd>JupyniumStartSync<cr>",                        desc = "Jupynium: Start Sync" },
  { "<leader>jq", "<cmd>JupyniumStopSync<cr>",                         desc = "Jupynium: Stop Sync" },
  -- Kernel
  { "<leader>jk", "<cmd>JupyniumKernelRestart<cr>",                    desc = "Jupynium: Restart Kernel" },
  { "<leader>ji", "<cmd>JupyniumKernelInterrupt<cr>",                  desc = "Jupynium: Interrupt Kernel" },
  { "<leader>jh", "<cmd>JupyniumKernelHover<cr>",                      desc = "Jupynium: Hover Variable" },
  -- Scroll / Output
  { "<leader>jo", "<cmd>JupyniumScrollToOutput<cr>",                   desc = "Jupynium: Scroll to Output" },
  { "<leader>jO", "<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>", desc = "Jupynium: Toggle Output Scroll" },
  -- Save / Download
  { "<leader>jw", "<cmd>JupyniumSaveIpynb<cr>",                        desc = "Jupynium: Save Notebook" },
  { "<leader>jd", "<cmd>JupyniumDownloadIpynb<cr>",                    desc = "Jupynium: Download ipynb" },
  { "<leader>jD", "<cmd>JupyniumAutoDownloadIpynbToggle<cr>",          desc = "Jupynium: Toggle Auto-Download" },
  -- Infrequent
  { "<leader>jS", "<cmd>JupyniumStartAndAttachToServerInTerminal<cr>", desc = "Jupynium: Start Server (Terminal)" },
  { "<leader>jK", "<cmd>JupyniumKernelSelect<cr>",                     desc = "Jupynium: Select Kernel" },
  { "<leader>jT", "<cmd>JupyniumKernelOpenInTerminal<cr>",             desc = "Jupynium: Kernel in Terminal" },
  { "<leader>jL", "<cmd>JupyniumLoadFromIpynbTabAndStartSync<cr>",     desc = "Jupynium: Load Tab + Sync" },
  { "<leader>jH", "<cmd>JupyniumShortsightedToggle<cr>",               desc = "Jupynium: Toggle Shortsighted" },
}

require("utils").map_keys(keys)

require("jupynium").setup({
  python_host = vim.fn.expand("$HOME/.local/share/jupynium/bin/python"),
  use_default_keybindings = false,
  textobjects = {
    use_default_keybindings = false
  },
  autoscroll = {
    focus = "output",
  },
})
