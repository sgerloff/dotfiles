return {
  { "christoomey/vim-tmux-navigator" },
  vim.keymap.set("n", "<c-k>", ":TmuxNavigateDown<CR>"),
  vim.keymap.set("n", "<c-j>", ":TmuxNavigateUp<CR>"),
  vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<CR>"),
  vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<CR>"),
}
