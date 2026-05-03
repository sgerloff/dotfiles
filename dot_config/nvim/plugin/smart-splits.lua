local keys = {
  { "<C-h>",      function() require("smart-splits").move_cursor_left() end,  desc = "Move left pane" },
  { "<C-j>",      function() require("smart-splits").move_cursor_down() end,  desc = "Move down pane" },
  { "<C-k>",      function() require("smart-splits").move_cursor_up() end,    desc = "Move up pane" },
  { "<C-l>",      function() require("smart-splits").move_cursor_right() end, desc = "Move right pane" },
  { "<C-S-h>",    function() require("smart-splits").move_cursor_left() end,  desc = "Move left pane" },
  { "<C-S-j>",    function() require("smart-splits").move_cursor_down() end,  desc = "Move down pane" },
  { "<C-S-k>",    function() require("smart-splits").move_cursor_up() end,    desc = "Move up pane" },
  { "<C-S-l>",    function() require("smart-splits").move_cursor_right() end, desc = "Move right pane" },
  { "<A-h>",      function() require("smart-splits").resize_left() end,       desc = "Resize pane left" },
  { "<A-j>",      function() require("smart-splits").resize_down() end,       desc = "Resize pane down" },
  { "<A-k>",      function() require("smart-splits").resize_up() end,         desc = "Resize pane up" },
  { "<A-l>",      function() require("smart-splits").resize_right() end,      desc = "Resize pane right" },
  { "<leader>wh", function() require("smart-splits").swap_buf_left() end,     desc = "Swap buffer left" },
  { "<leader>wj", function() require("smart-splits").swap_buf_down() end,     desc = "Swap buffer down" },
  { "<leader>wk", function() require("smart-splits").swap_buf_up() end,       desc = "Swap buffer up" },
  { "<leader>wl", function() require("smart-splits").swap_buf_right() end,    desc = "Swap buffer right" },
}

require("utils").map_keys(keys)

require("smart-splits").setup({
  at_edge = "wrap",
})
