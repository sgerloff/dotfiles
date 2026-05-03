-- General keymaps (non-plugin-specific)

-- Lowercase global marks (swap case: lowercase mark keys use uppercase registers)
local low = function(i) return string.char(97 + i) end
local upp = function(i) return string.char(65 + i) end

for i = 0, 25 do vim.keymap.set("n", "m" .. low(i), "m" .. upp(i)) end
for i = 0, 25 do vim.keymap.set("n", "m" .. upp(i), "m" .. low(i)) end
for i = 0, 25 do vim.keymap.set("n", "'" .. low(i), "'" .. upp(i)) end
for i = 0, 25 do vim.keymap.set("n", "'" .. upp(i), "'" .. low(i)) end

-- Execute Lua
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Diagnostics
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Handle Wrapped-Text movement
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Better movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down", noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up", noremap = true })

-- Window management
vim.keymap.set("n", "<leader>wb", "<C-w>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Delete Window", remap = true })
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", { desc = "Write File", remap = true })
vim.keymap.set("n", "<leader>wW", "<cmd>wa<CR>", { desc = "Write All", remap = true })

-- Undo breakpoints
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Persist selection on indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Terminal escape
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
vim.keymap.set("n", "<leader>qdw", function() vim.cmd("QfDiagnosticsW") end, { desc = "Quickfix: diagnostic list (warn)" })
vim.keymap.set("n", "<leader>qde", function() vim.cmd("QfDiagnosticsE") end, { desc = "Quickfix: diagnostic list (error)" })

-- Buffer
vim.keymap.set("n", "<leader>bb", function() vim.cmd("bufdo e") end, { desc = "Buffer: reload all" })
