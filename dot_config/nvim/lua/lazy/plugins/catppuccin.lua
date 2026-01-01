return {
  {
    "catppuccin/nvim",
    version = "*",
    enabled = true,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true
        },
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },
}
