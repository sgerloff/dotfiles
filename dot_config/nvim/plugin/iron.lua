local utils = require("utils")

local keys = {
  {
    "<leader>RT",
    function()
      vim.cmd("IronFocus")
      vim.api.nvim_feedkeys("A", "n", false)
    end,
    desc = "Iron: Focus REPL",
  },
}

utils.map_keys(keys)

local iron = require("iron.core")
local common = require("iron.fts.common")

iron.setup({
  config = {
    scratch_repl = false,
    repl_definition = {
      python = {
        command = function()
          local python_path = utils.infer_python_shell()
          return { python_path, "--no-autoindent" }
        end,
        format = common.bracketed_paste_python,
        block_dividers = { "# %%", "#%%", "# COMMAND", "#COMMAND" },
      },
    },
    repl_filetype = function(bufnr, ft)
      local supported_ft = { "python" }
      if supported_ft[ft] ~= nil then
        return ft
      else
        return "python"
      end
    end,
    repl_open_cmd = function(bufnr)
      local snacks_win = require("snacks").win({
        buf = bufnr,
        position = "right",
        width = 0.3,
        style = "terminal",
        wo = {
          winbar = "Iron REPL",
        },
      })
      return snacks_win.win
    end,
  },
  keymaps = {
    toggle_repl = "<leader>rt",
    restart_repl = "<leader>rT",
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
    italic = true,
  },
  ignore_blank_lines = true,
})
