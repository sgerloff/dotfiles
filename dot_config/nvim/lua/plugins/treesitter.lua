return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "^0.9.3",
    enabled = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "vim",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "vimdoc",
          "just",
          "bash",
          "json",
          "mermaid",
          "csv",
          "tsv",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 1000 * 1024 -- 1000 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
}
