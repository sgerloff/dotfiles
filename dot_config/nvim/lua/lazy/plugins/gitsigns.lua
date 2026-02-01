return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  enabled = true,
  opts = {
    on_attach = function(bufnr)
      local function map_key(key_table)
        local opts = {
          buffer = bufnr,
          desc = key_table.desc
        }
        vim.keymap.set(key_table.mode, key_table[1], key_table[2], opts)
      end

      local keymaps = require("lazy.config.keymaps").LazyPluginKeys["lewis6991/gitsigns.nvim"]
      for _, key_table in ipairs(keymaps) do
        map_key(key_table)
      end
    end,
    word_diff = true,
    current_line_blame_opts = {
      virt_text_pos = "eol",
      use_focus = false,
      delay = 100,
    }
  }
}
