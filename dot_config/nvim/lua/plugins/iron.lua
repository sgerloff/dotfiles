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
          local supported_ft = {"python"}
          if supported_ft[ft] ~= nil then
            return ft
          else
            return "python"
          end
        end,
        repl_open_cmd = view.right(80),
      },
      keymaps = {
        toggle_repl = "<leader>rt", -- toggles the repl open and closed.
        restart_repl = "<leader>rT", -- calls `IronRestart` to restart the repl
        send_motion = "<leader>rm",
        visual_send = "<leader>rv",
        send_file = "<leader>rf",
        send_line = "<leader>RR",
        send_paragraph = "<leader>rR",
        send_until_cursor = "<leader>ru",
        send_mark = "<leader>mm",
        send_code_block = "<leader>rr",
        send_code_block_and_move = "<leader>rn",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr = "<leader>r<cr>",
        interrupt = "<leader>r<leader>",
        exit = "<leader>rq",
        clear = "<leader>Rt",
      },
      highlight = {
        italic = true
      },
      ignore_blank_lines = true,
    })
  end,
}
