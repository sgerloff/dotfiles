-- Keymaps are automatically laded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Lowercase global marks
local low = function(i) return string.char(97 + i) end
local upp = function(i) return string.char(65 + i) end

for i = 0, 25 do vim.keymap.set("n", "m" .. low(i), "m" .. upp(i)) end
for i = 0, 25 do vim.keymap.set("n", "m" .. upp(i), "m" .. low(i)) end
for i = 0, 25 do vim.keymap.set("n", "'" .. low(i), "'" .. upp(i)) end
for i = 0, 25 do vim.keymap.set("n", "'" .. upp(i), "'" .. low(i)) end

-- Execute LUA
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "<leader>RT", function()
  vim.cmd("IronFocus")
  vim.api.nvim_feedkeys("A", "n", false)
end, { desc = "Iron: Focus REPL" })

-- Diagnostics
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Handle Wrapped-Text movement
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Down", expr = true, silent = true })

-- Better movement
vim.keymap.set({ "n" }, "<C-d>", "<C-d>zz", { desc = "Half-page down", noremap = true })
vim.keymap.set({ "n" }, "<C-u>", "<C-u>zz", { desc = "Half-page up", noremap = true })

vim.keymap.set("n", "<leader>wb", "<C-w>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", remap = true })
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", { desc = "Write File", remap = true })
vim.keymap.set("n", "<leader>wW", "<cmd>wa<CR>", { desc = "Write All", remap = true })


-- Undo breakpoint for better undo (e.g. undo until the last ',')
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Persist selection on indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Quickfix
vim.keymap.set("n", "<leader>qq", vim.cmd.cnext, { desc = "Quickfix: go next" })
vim.keymap.set("n", "<leader>qQ", vim.cmd.cprev, { desc = "Quickfix: go previous" })
vim.keymap.set("n", "<leader>ql", vim.cmd.copen, { desc = "Quickfix: open list" })
vim.keymap.set("n", "<leader>qL", vim.cmd.cclose, { desc = "Quickfix: close list" })
vim.keymap.set("n", "<leader>qgg", vim.cmd.cfirst, { desc = "Quickfix: go first" })
vim.keymap.set("n", "<leader>qG", vim.cmd.clast, { desc = "Quickfix: go last" })
vim.keymap.set("n", "<leader>qR", function() vim.fn.setqflist({}, "r") end, { desc = "Quickfix: reset list" })
vim.keymap.set("n", "<leader>qdd", function() vim.cmd("QfDiagnostics") end, { desc = "Quickfix: diagnostic list" })
vim.keymap.set("n", "<leader>qdw", function() vim.cmd("QfDiagnosticsW") end, { desc = "Quickfix: diagnostic list" })
vim.keymap.set("n", "<leader>qde", function() vim.cmd("QfDiagnosticsE") end, { desc = "Quickfix: diagnostic list" })

-- Buffer
vim.keymap.set("n", "<leader>bb", function() vim.cmd("bufdo e") end, { desc = "Buffer: reload all" })

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

M.LazyPluginKeys["stevearc/conform.nvim"] = {
  {
    "<leader>cf",
    function()
      require("conform").format({
        timeout_ms = 3000,
        async = true
      })
    end,
    mode = { "n", "v" },
    desc = "Format Injected Langs"
  }
}
---@diagnostic disable: undefined-global
M.LazyPluginKeys["folke/snacks.nvim"] = {
  { "<leader>,",  function() Snacks.picker.buffers() end,                                                        desc = "Buffers" },
  { "<leader>/",  function() Snacks.picker.grep() end,                                                           desc = "Grep" },
  { "<leader>:",  function() Snacks.picker.command_history() end,                                                desc = "Command History" },
  { "<leader>n",  function() Snacks.picker.notifications() end,                                                  desc = "Notification History" },
  { "<leader>e",  function() Snacks.explorer({ focus = "list", auto_close = true }) end,                         desc = "File Explorer" },
  -- find
  { "<leader>fb", function() Snacks.picker.buffers() end,                                                        desc = "Buffers" },
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                        desc = "Find Config File" },
  { "<leader>ff", function() Snacks.picker.files({ hidden = true, ignored = true, exclude = { ".venv*" } }) end, desc = "Find Files" },
  { "<leader>fg", function() Snacks.picker.git_files() end,                                                      desc = "Find Git Files" },
  { "<leader>fp", function() Snacks.picker.projects() end,                                                       desc = "Projects" },
  { "<leader>fr", function() Snacks.picker.recent() end,                                                         desc = "Recent" },
  { "<leader>fs", function() Snacks.picker.smart() end,                                                          desc = "Smart Find Files" },
  -- git
  { "<leader>gb", function() Snacks.picker.git_branches() end,                                                   desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end,                                                        desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end,                                                   desc = "Git Log Line" },
  { "<leader>gs", function() Snacks.picker.git_status() end,                                                     desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end,                                                      desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end,                                                       desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end,                                                   desc = "Git Log File" },
  -- Grep
  { "<leader>sb", function() Snacks.picker.lines() end,                                                          desc = "Buffer Lines" },
  { "<leader>sB", function() Snacks.picker.grep_buffers() end,                                                   desc = "Grep Open Buffers" },
  { "<leader>sg", function() Snacks.picker.grep() end,                                                           desc = "Grep" },
  { "<leader>sw", function() Snacks.picker.grep_word() end,                                                      desc = "Visual selection or word", mode = { "n", "x" } },
  -- search
  { '<leader>s"', function() Snacks.picker.registers() end,                                                      desc = "Registers" },
  { '<leader>s/', function() Snacks.picker.search_history() end,                                                 desc = "Search History" },
  { "<leader>sa", function() Snacks.picker.autocmds() end,                                                       desc = "Autocmds" },
  { "<leader>sb", function() Snacks.picker.lines() end,                                                          desc = "Buffer Lines" },
  { "<leader>sc", function() Snacks.picker.command_history() end,                                                desc = "Command History" },
  { "<leader>sC", function() Snacks.picker.commands() end,                                                       desc = "Commands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end,                                                    desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                                             desc = "Buffer Diagnostics" },
  { "<leader>sh", function() Snacks.picker.help() end,                                                           desc = "Help Pages" },
  { "<leader>sH", function() Snacks.picker.highlights() end,                                                     desc = "Highlights" },
  { "<leader>si", function() Snacks.picker.icons() end,                                                          desc = "Icons" },
  { "<leader>sj", function() Snacks.picker.jumps() end,                                                          desc = "Jumps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end,                                                        desc = "Keymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end,                                                        desc = "Location List" },
  { "<leader>sm", function() Snacks.picker.marks() end,                                                          desc = "Marks" },
  { "<leader>sM", function() Snacks.picker.man() end,                                                            desc = "Man Pages" },
  { "<leader>sp", function() Snacks.picker.lazy() end,                                                           desc = "Search for Plugin Spec" },
  { "<leader>sq", function() Snacks.picker.qflist() end,                                                         desc = "Quickfix List" },
  { "<leader>sR", function() Snacks.picker.resume() end,                                                         desc = "Resume" },
  { "<leader>su", function() Snacks.picker.undo() end,                                                           desc = "Undo History" },
  { "<leader>uC", function() Snacks.picker.colorschemes() end,                                                   desc = "Colorschemes" },
  -- LSP
  { "gd",         function() Snacks.picker.lsp_definitions() end,                                                desc = "Goto Definition" },
  { "gD",         function() Snacks.picker.lsp_declarations() end,                                               desc = "Goto Declaration" },
  { "gR",         function() Snacks.picker.lsp_references() end,                                                 nowait = true,                     desc = "References" },
  { "gI",         function() Snacks.picker.lsp_implementations() end,                                            desc = "Goto Implementation" },
  { "gy",         function() Snacks.picker.lsp_type_definitions() end,                                           desc = "Goto T[y]pe Definition" },
  { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                                                    desc = "LSP Symbols" },
  { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                                          desc = "LSP Workspace Symbols" },
  -- Terminals
  { "<leader>tt", function() Snacks.terminal.toggle() end,                                                       desc = "Toggle Terminal" },
  {
    "<leader>tP",
    function()
      Snacks.terminal.toggle(require("config.utils").infer_python_shell(),
        { win = { position = "right", ft = "python", min_width = 85, width = 0.4 } })
    end,
    desc = "Toggle Python Terminal"
  },
  -- UI
  { "<leader>uz", function() Snacks.zen.zen() end,            desc = "Zoom Buffer" },
  { "<leader>uZ", function() Snacks.zen.zoom() end,           desc = "Zoom Buffer" },
  { "<leader>us", require("config.utils").toggle_scratch_win, desc = "Scratch Buffer" }
}
---@diagnostic enable: undefined-global

M.LazyPluginKeys["mfussenegger/nvim-dap"] = {
  -- { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
  { "<leader>dB", function() require("config.utils").dapui_float_element("breakpoints", 0.7) end,       desc = "Breakpoints (Floating)" },
  { "<leader>dC", function() require("config.utils").dapui_float_element("console", 0.7) end,           desc = "Console (Floating)" },
  { "<leader>dD", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  { "<leader>dG", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
  { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
  { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
  { "<leader>dR", function() require("config.utils").dapui_float_element("repl", 0.7) end,              desc = "REPL (Floating)" },
  { "<leader>dS", function() require("dap").session() end,                                              desc = "Session" },
  { "<leader>dT", function() require("dap").terminate() end,                                            desc = "Terminate" },
  { "<leader>dW", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
  { "<leader>dd", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
  { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                        mode = { "n", "v" } },
  { "<leader>df", function() require("config.utils").dapui_float_element("stacks", 0.7) end,            desc = "Stacks and Frames (Floating)" },
  { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
  { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
  { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
  { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
  { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
  { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
  { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
  { "<leader>ds", function() require("config.utils").dapui_float_element("scopes", 0.7) end,            desc = "Scopes (Floating)" },
  { "<leader>dt", function() require("dap-python").test_method() end,                                   desc = "Pytest Function",             mode = { "n" } },
  { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
  { "<leader>dw", function() require("config.utils").dapui_float_element("watches", 0.7) end,           desc = "Watches (Floating)" },
}

M.LazyPluginKeys["mrjones2014/smart-splits.nvim"] = {
  { "<C-h>",      function() require("smart-splits").move_cursor_left() end,  desc = "Move left pane",      mode = { "n" } },
  { "<C-j>",      function() require("smart-splits").move_cursor_down() end,  desc = "Move down pane",      mode = { "n" } },
  { "<C-k>",      function() require("smart-splits").move_cursor_up() end,    desc = "Move up pane",        mode = { "n" } },
  { "<C-l>",      function() require("smart-splits").move_cursor_right() end, desc = "Move right pane",     mode = { "n" } },
  { "<C-S-h>",    function() require("smart-splits").move_cursor_left() end,  desc = "Move left pane",      mode = { "n" } },
  { "<C-S-j>",    function() require("smart-splits").move_cursor_down() end,  desc = "Move down pane",      mode = { "n" } },
  { "<C-S-k>",    function() require("smart-splits").move_cursor_up() end,    desc = "Move up pane",        mode = { "n" } },
  { "<C-S-l>",    function() require("smart-splits").move_cursor_right() end, desc = "Move right pane",     mode = { "n" } },
  { "<A-h>",      function() require("smart-splits").resize_left() end,       desc = "Resize pane left",    mode = { "n" } },
  { "<A-j>",      function() require("smart-splits").resize_down() end,       desc = "Resize pane down",    mode = { "n" } },
  { "<A-k>",      function() require("smart-splits").resize_up() end,         desc = "Resize pane up",      mode = { "n" } },
  { "<A-l>",      function() require("smart-splits").resize_right() end,      desc = "Resize pane right",   mode = { "n" } },
  { "<leader>wh", function() require("smart-splits").swap_buf_left() end,     desc = "Swap buffer to left", mode = { "n" } },
  { "<leader>wj", function() require("smart-splits").swap_buf_down() end,     desc = "Swap buffer to left", mode = { "n" } },
  { "<leader>wk", function() require("smart-splits").swap_buf_up() end,       desc = "Swap buffer to left", mode = { "n" } },
  { "<leader>wl", function() require("smart-splits").swap_buf_right() end,    desc = "Swap buffer to left", mode = { "n" } },
}

M.LazyPluginKeys["folke/flash.nvim"] = {

  -- { "<leader><leader>", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
  { "ö", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  { "Ö", mode = { "n", "x", "o" }, function() require("flash").treesitter_search() end, desc = "Flash Treesitter" },
  -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
  -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
}

setmetatable(M.LazyPluginKeys, {
  __index = function(_, _)
    return {}
  end
})

return M
