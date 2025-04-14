return {
  "Vigemus/iron.nvim",
  enabled = true,
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        scratch_repl = false,
        repl_definition = {
          python = {
            command = function()
              python_path = require("config.utils").infer_python_shell()
              return { python_path, "--no-autoindent" }
            end,
            format = common.bracketed_paste_python,
            block_dividers = { "# %%", "#%%", "# COMMAND", "#COMMAND" }
          }
        },
        repl_filetype = function(bufnr, ft)
          return ft
        end,
        repl_open_cmd = view.right(80),
      },
      keymaps = {
        toggle_repl = "<leader>rr", -- toggles the repl open and closed.
        restart_repl = "<leader>rR", -- calls `IronRestart` to restart the repl
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_paragraph = "<leader>sp",
        send_until_cursor = "<leader>su",
        send_mark = "<leader>sm",
        send_code_block = "<leader>sb",
        send_code_block_and_move = "<leader>sn",

        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr = "<leader>s<cr>",
        interrupt = "<leader>s<leader>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
      highlight = {
        italic = true
      },
      ignore_blank_lines = true,
    })
  end
}
