-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local treesitter_keymaps = {
  { key = "+a", motion = "goto_next_start", textobj = "@parameter.inner" },
  { key = "+A", motion = "goto_next_end", textobj = "@parameter.inner" },
  { key = "üa", motion = "goto_previous_start", textobj = "@parameter.inner" },
  { key = "üA", motion = "goto_previous_end", textobj = "@parameter.inner" },
  { key = "+f", motion = "goto_next_start", textobj = "@function.outer" },
  { key = "+F", motion = "goto_next_end", textobj = "@function.outer" },
  { key = "üf", motion = "goto_previous_start", textobj = "@function.outer" },
  { key = "üF", motion = "goto_previous_end", textobj = "@function.outer" },
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
