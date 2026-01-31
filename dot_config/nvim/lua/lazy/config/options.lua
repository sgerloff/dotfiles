-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = "$HOME/.local/share/nvim_venv/bin/python3"

vim.opt.clipboard = "unnamedplus"

vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smartindent = true
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes:2"
vim.opt.conceallevel = 2 -- Handles conversion of characters to symbols better
vim.opt.cursorline = true
vim.opt.foldlevel = 99   -- practically keep all folds open
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

-- File Related
vim.opt.autowrite = true
vim.opt.confirm = true -- prompts to save up-on closing unsaved buffers

vim.opt.completeopt = "menu,menuone,noselect"
