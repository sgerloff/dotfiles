local keys = {
  { "ö", function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash" },
  { "Ö", function() require("flash").treesitter_search() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
}

require("utils").map_keys(keys)

require("flash").setup({
  search = {
    mode = "exact",
  },
})
