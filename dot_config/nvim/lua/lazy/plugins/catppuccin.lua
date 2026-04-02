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
        custom_highlights = function(colors)
          local highlights = {}

          local spell_options = {
            style = { "underline" }
          }
          local spell_groups = {
            "SpellBad",
            "SpellCap",
            "SpellLocal",
            "SpellRare"
          }
          for _, v in ipairs(spell_groups) do
            highlights[v] = spell_options
          end

          return highlights
        end
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },
}
