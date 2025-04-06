return {
  {
    "aserowy/tmux.nvim",
    enabled = true,
    config = function() return require("tmux").setup() end
  }
}
