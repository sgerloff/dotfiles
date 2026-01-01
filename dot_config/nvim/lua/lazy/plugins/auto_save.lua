return {
  {
    "okuuva/auto-save.nvim",
    version = '*',
    enabled = true,
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {}
  },
}
