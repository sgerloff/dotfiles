local utils = require("utils")

local keys = {
  -- Buffers
  { "<leader>,",  function() Snacks.picker.buffers() end,                                                               desc = "Buffers" },
  { "<leader>/",  function() Snacks.picker.grep() end,                                                                  desc = "Grep" },
  { "<leader>:",  function() Snacks.picker.command_history() end,                                                       desc = "Command History" },
  { "<leader>n",  function() Snacks.picker.notifications() end,                                                         desc = "Notification History" },
  { "<leader>e",  function() Snacks.explorer({ focus = "list", auto_close = true, hidden = true, ignored = true }) end, desc = "File Explorer" },
  -- Find
  { "<leader>fb", function() Snacks.picker.buffers() end,                                                               desc = "Buffers" },
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                               desc = "Find Config File" },
  { "<leader>ff", function() Snacks.picker.files({ hidden = true, ignored = true, exclude = { ".venv*" } }) end,        desc = "Find Files" },
  { "<leader>fg", function() Snacks.picker.git_files() end,                                                             desc = "Find Git Files" },
  { "<leader>fp", function() Snacks.picker.projects() end,                                                              desc = "Projects" },
  { "<leader>fr", function() Snacks.picker.recent() end,                                                                desc = "Recent" },
  { "<leader>fs", function() Snacks.picker.smart() end,                                                                 desc = "Smart Find Files" },
  -- Git
  { "<leader>gb", function() Snacks.picker.git_branches() end,                                                          desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end,                                                               desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end,                                                          desc = "Git Log Line" },
  { "<leader>gs", function() Snacks.picker.git_status() end,                                                            desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end,                                                             desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end,                                                              desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end,                                                          desc = "Git Log File" },
  -- Grep
  { "<leader>sb", function() Snacks.picker.lines() end,                                                                 desc = "Buffer Lines" },
  { "<leader>sB", function() Snacks.picker.grep_buffers() end,                                                          desc = "Grep Open Buffers" },
  { "<leader>sg", function() Snacks.picker.grep() end,                                                                  desc = "Grep" },
  { "<leader>sw", function() Snacks.picker.grep_word() end,                                                             desc = "Visual selection or word", mode = { "n", "x" } },
  -- Search
  { '<leader>s"', function() Snacks.picker.registers() end,                                                             desc = "Registers" },
  { '<leader>s/', function() Snacks.picker.search_history() end,                                                        desc = "Search History" },
  { "<leader>sa", function() Snacks.picker.autocmds() end,                                                              desc = "Autocmds" },
  { "<leader>sc", function() Snacks.picker.command_history() end,                                                       desc = "Command History" },
  { "<leader>sC", function() Snacks.picker.commands() end,                                                              desc = "Commands" },
  { "<leader>sd", function() Snacks.picker.diagnostics() end,                                                           desc = "Diagnostics" },
  { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                                                    desc = "Buffer Diagnostics" },
  { "<leader>sh", function() Snacks.picker.help() end,                                                                  desc = "Help Pages" },
  { "<leader>sH", function() Snacks.picker.highlights() end,                                                            desc = "Highlights" },
  { "<leader>si", function() Snacks.picker.icons() end,                                                                 desc = "Icons" },
  { "<leader>sj", function() Snacks.picker.jumps() end,                                                                 desc = "Jumps" },
  { "<leader>sk", function() Snacks.picker.keymaps() end,                                                               desc = "Keymaps" },
  { "<leader>sl", function() Snacks.picker.loclist() end,                                                               desc = "Location List" },
  { "<leader>sm", function() Snacks.picker.marks() end,                                                                 desc = "Marks" },
  { "<leader>sM", function() Snacks.picker.man() end,                                                                   desc = "Man Pages" },
  { "<leader>sp", function() Snacks.picker.lazy() end,                                                                  desc = "Search for Plugin Spec" },
  { "<leader>sq", function() Snacks.picker.qflist() end,                                                                desc = "Quickfix List" },
  { "<leader>sR", function() Snacks.picker.resume() end,                                                                desc = "Resume" },
  { "<leader>su", function() Snacks.picker.undo() end,                                                                  desc = "Undo History" },
  { "<leader>uC", function() Snacks.picker.colorschemes() end,                                                          desc = "Colorschemes" },
  -- LSP
  { "gd",         function() Snacks.picker.lsp_definitions() end,                                                       desc = "Goto Definition" },
  { "gD",         function() Snacks.picker.lsp_declarations() end,                                                      desc = "Goto Declaration" },
  { "gR",         function() Snacks.picker.lsp_references() end,                                                        nowait = true,                     desc = "References" },
  { "gI",         function() Snacks.picker.lsp_implementations() end,                                                   desc = "Goto Implementation" },
  { "gy",         function() Snacks.picker.lsp_type_definitions() end,                                                  desc = "Goto T[y]pe Definition" },
  { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                                                           desc = "LSP Symbols" },
  { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                                                 desc = "LSP Workspace Symbols" },
  -- Terminals
  { "<leader>tt", function() Snacks.terminal.toggle() end,                                                              desc = "Toggle Terminal" },
  {
    "<leader>tP",
    function()
      Snacks.terminal.toggle(utils.infer_python_shell(),
        { win = { position = "right", ft = "python", min_width = 85, width = 0.4 } })
    end,
    desc = "Toggle Python Terminal",
  },
  -- UI
  { "<leader>uz", function() Snacks.zen.zen() end,  desc = "Zen Mode" },
  { "<leader>uZ", function() Snacks.zen.zoom() end, desc = "Zoom Buffer" },
  { "<leader>us", utils.toggle_scratch_win,         desc = "Scratch Buffer" },
}

utils.map_keys(keys)

-- Snacks setup
require("snacks").setup({
  picker = {},
  explorer = {},
  statuscolumn = { enabled = false },
  zen = {
    toggles = {
      dim = false,
    },
    win = {
      width = 160,
    },
    show = {
      statusline = true,
      tabline = true,
    },
  },
})

-- Statuscolumn (depends on snacks being loaded)
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
