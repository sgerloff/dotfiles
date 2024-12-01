-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local treesitter_keymaps = {
  { key = "<leader>ta", motion = "goto_next_start", textobj = "@parameter.inner" },
  { key = "<leader>tA", motion = "goto_next_end", textobj = "@parameter.inner" },
  { key = "<leader>Ta", motion = "goto_previous_start", textobj = "@parameter.inner" },
  { key = "<leader>TA", motion = "goto_previous_end", textobj = "@parameter.inner" },
  { key = "<leader>tf", motion = "goto_next_start", textobj = "@function.outer" },
  { key = "<leader>tF", motion = "goto_next_end", textobj = "@function.outer" },
  { key = "<leader>Tf", motion = "goto_previous_start", textobj = "@function.outer" },
  { key = "<leader>TF", motion = "goto_previous_end", textobj = "@function.outer" },
}

for _, map in ipairs(treesitter_keymaps) do
  vim.keymap.set(
    "n",
    map.key,
    require("config.utils").dot_repeat(function()
      require("nvim-treesitter.textobjects.move")[map.motion](map.textobj)
    end),
    { expr = true }
  )
end
