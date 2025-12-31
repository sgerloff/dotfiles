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

vim.api.nvim_create_user_command("QfDiagnostics", function()
  vim.diagnostic.setqflist()
end, {})

vim.api.nvim_create_user_command("QfDiagnosticsW", function()
  vim.diagnostic.setqflist({ severtiy = vim.diagnostic.severity.WARN })
end, {})

vim.api.nvim_create_user_command("QfDiagnosticsE", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, {})
