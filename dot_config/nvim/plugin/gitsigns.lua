local keys = {
  { "<leader>gh", function() require("gitsigns").preview_hunk_inline() end,       desc = "Gitsigns: Preview Hunk" },
  { "<leader>gB", function() require("gitsigns").toggle_current_line_blame() end, desc = "Gitsigns: Git Blame" },
  { "<leader>gw", function() require("gitsigns").toggle_word_diff() end,          desc = "Gitsigns: Toggle Word Diff" },
  {
    "<leader>gr",
    function()
      if vim.wo.diff then
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match("gitsigns://") then
            vim.api.nvim_win_close(win, true)
          end
        end
      else
        require("gitsigns").diffthis()
      end
    end,
    desc = "Gitsigns: Review Diff",
  },
  {
    "<leader>gC",
    function()
      Snacks.picker.git_log({
        confirm = function(picker, item)
          picker:close()
          if item and item.commit then
            require("gitsigns").change_base(item.commit, true)
          end
        end,
      })
    end,
    desc = "Gitsigns: Change Revision",
  },
  {
    "<leader>gc",
    function()
      Snacks.picker.git_branches({
        confirm = function(picker, item)
          picker:close()
          if item and item.branch then
            require("gitsigns").change_base(item.branch, true)
          end
        end,
      })
    end,
    desc = "Gitsigns: Change Revision (Branch)",
  },
}

require("gitsigns").setup({
  on_attach = function(bufnr)
    require("utils").map_keys(keys, { buffer = bufnr })
  end,
  word_diff = true,
  current_line_blame_opts = {
    virt_text_pos = "eol",
    use_focus = false,
    delay = 100,
  },
})
