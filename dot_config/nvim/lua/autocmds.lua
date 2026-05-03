-- General autocmds (non-plugin-specific)

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "" then
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false
      vim.opt_local.statuscolumn = ""
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  command = "wincmd L",
})
