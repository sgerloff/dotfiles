return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    -- see below for full list of optional dependencies 👇
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "dnd_k3",
        path = "~/vaults/Ventures Unknown (Kampagne 3)",
      },
    },
    templates = {
      folder = "__templates__",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    -- see below for full list of options 👇
  },
}
