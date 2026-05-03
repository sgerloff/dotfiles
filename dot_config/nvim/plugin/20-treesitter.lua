require("nvim-treesitter").setup({})

-- Treesitter user command for installing parsers
vim.api.nvim_create_user_command("TSEnsureInstalled", function()
  local ensure_installed = {
    "vim", "lua", "markdown", "markdown_inline", "python",
    "vimdoc", "just", "bash", "json", "mermaid", "csv", "tsv",
    "yaml", "html",
  }
  require("nvim-treesitter").install(ensure_installed)
end, {})

-- Enable treesitter highlighting and indentation for all filetypes
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
