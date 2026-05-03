local keys = {
  {
    "<leader>?",
    function() require("which-key").show({ global = false }) end,
    desc = "Buffer Local Keymaps (which-key)",
  },
}

require("utils").map_keys(keys)

require("which-key").setup({
  preset = "modern",
})
