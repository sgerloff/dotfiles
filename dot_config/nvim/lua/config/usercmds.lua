vim.api.nvim_create_user_command(
  "PythonTerminal",
  function()
    local python_path = require("config/utils").infer_python_shell()
    vim.cmd("terminal " .. python_path)
    vim.cmd("startinsert")
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value("filetype", "python_terminal", { buf = buf })
  end,
  {}
)
