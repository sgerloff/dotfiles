return {
  {
    "Olical/conjure",
    enabled = true,
    version = "^4.54.0",
    lazy = true,
    init = function()
      vim.g["conjure#mapping#doc_word"] = false
    end,
    dependencies = { "PaterJason/cmp-conjure" },
  },
}
