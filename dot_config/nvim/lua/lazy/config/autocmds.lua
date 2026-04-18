-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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
  command = "wincmd L"
})

vim.api.nvim_create_autocmd(
  'User',
  {
    pattern = 'MiniSnippetsSessionStart',
    callback = function()
      local au_opts = { pattern = '*:n', once = true }
      au_opts.callback = function()
        while MiniSnippets.session.get() do
          MiniSnippets.session.stop()
        end
      end
      vim.api.nvim_create_autocmd('ModeChanged', au_opts)
    end
  }
)
