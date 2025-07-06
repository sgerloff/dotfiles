return {
  {
    "okuuva/auto-save.nvim",
    version = '^1.0.0',
    enabled = true,
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {}
  },
}
