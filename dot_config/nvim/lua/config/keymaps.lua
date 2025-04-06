-- Keymaps are automatically laded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


-- Execute LUA
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Handle Wrapped-Text movement
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Down", expr = true, silent = true })

-- Navigate Windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set("n", "<leader>wb", "<C-w>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", remap = true })

vim.keymap.set("n", "<leader>wk", require("config.utils").dot_repeat(function() vim.cmd("resize +2") end),
  { desc = "Increase Window Height", expr = true, silent = true })
vim.keymap.set("n", "<leader>wj", require("config.utils").dot_repeat(function() vim.cmd("resize -2") end),
  { desc = "Decrease Window Height", expr = true, silent = true })
vim.keymap.set("n", "<leader>wh", require("config.utils").dot_repeat(function() vim.cmd("vertical resize -2") end),
  { desc = "Decrease Window Width", expr = true, silent = true })
vim.keymap.set("n", "<leader>wl", require("config.utils").dot_repeat(function() vim.cmd("vertical resize +2") end),
  { desc = "Increase Window Width", expr = true, silent = true })

-- Undo breakpoint for better undo (e.g. undo until the last ',')
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Persist selection on indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- PLUGIN KEYS
local M = {}

M.LazyPluginKeys = {}

M.LazyPluginKeys["lsp_on_attach"] = {
  { "<leader>cl", "<cmd>LspInfo<cr>",                                 desc = "Lsp Info" },
  { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover" },
  { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",             has = "signatureHelp" },
  { "<c-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                          desc = "Signature Help", has = "signatureHelp" },
  { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code Action",                mode = { "n", "v" },     has = "codeAction" },
  { "<leader>cc", vim.lsp.codelens.run,                               desc = "Run Codelens",               mode = { "n", "v" },     has = "codeLens" },
  { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display Codelens", mode = { "n" },          has = "codeLens" },
  { "<leader>cr", vim.lsp.buf.rename,                                 desc = "Rename",                     has = "rename" },
}

---@diagnostic disable: undefined-global
M.LazyPluginKeys["folke/snacks.nvim"] = {
  { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
  { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
  { "<leader>e",       function() Snacks.explorer({ focus = "list", auto_close = true }) end,  desc = "File Explorer" },
  -- find
  { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
  { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
  -- git
  { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
  { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
  { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
  { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
  -- Grep
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
  { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
  { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
  { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
  { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
  { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
  { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
  { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
  { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
  { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
  { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
  { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
  { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
  { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
  { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
  { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
  { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
  { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
  { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
  -- LSP
  { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
  { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
  { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
  { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
  { "<leader>ft",      function() Snacks.terminal.toggle() end,                                desc = "Toggle Terminal" },
  {
    "<leader>fP",
    function()
      Snacks.terminal.toggle(require("config.utils").infer_python_shell(),
        { win = { position = "right", ft = "python", min_width=85, width=0.4 } })
    end,
    desc = "Toggle Terminal"
  }
}
---@diagnostic enable: undefined-global

M.LazyPluginKeys["mfussenegger/nvim-dap"] = {
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
  { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
  -- { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
  { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
  { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
  { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
  { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
  { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
  { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
  { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
  { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
  { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
  { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
  { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
  { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
  { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
  { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                   mode = { "n", "v" } },
}

setmetatable(M.LazyPluginKeys, {
  __index = function(_, _)
    return {}
  end
})

return M
