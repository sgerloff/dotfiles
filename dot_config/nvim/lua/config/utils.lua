local M = {}
--Returns a dot repeatable version of a function to be used in keymaps
--that pressing `.` will repeat the action.
--Example: `vim.keymap.set('n', 'ct', dot_repeat(function() print(os.clock()) end), { expr = true })`
--Setting expr = true in the keymap is required for this function to make the keymap repeatable

--based on gist: https://gist.github.com/kylechui/a5c1258cd2d86755f97b10fc921315c3
function M.dot_repeat(
    callback --[[Function]]
)
  return function()
    _G.dot_repeat_callback = callback
    vim.go.operatorfunc = "v:lua.dot_repeat_callback"
    return "g@l"
  end
end

function M.get_python_path()
  local venv_path = os.getenv("VIRTUAL_ENV")
  if venv_path ~= nil and venv_path ~= "" then
    venv_path = venv_path .. "/bin/python"
  end
  if venv_path == nil then
    venv_path = vim.fn.findfile(".venv/bin/python", vim.fn.getcwd() .. ";")
  end
  if venv_path == "" then
    venv_path = vim.fn.findfile("venv/bin/python", vim.fn.getcwd() .. ";")
  end
  if venv_path ~= "" then
    venv_path = vim.fn.fnamemodify(venv_path, ":p") -- abs path
    return venv_path
  else
    return vim.g.python3_host_prog
  end
end

function M.infer_python_shell()
  local venv_path = M.get_python_path()
  if venv_path == nil then
    return "python"
  end

  local potential_ipython_path = venv_path:gsub("/python$", "/ipython")
  if vim.fn.filereadable(potential_ipython_path) then
    return potential_ipython_path
  end
  if vim.fn.filereadable(venv_path) then
    return venv_path
  end
end

function M.get_center_padded_statuscolumn()
  local tw = vim.bo.textwidth

  if tw == 0 then
    -- return require("snacks.statuscolumn").get()
    tw = 120
  end

  -- local win_id = vim.api.nvim_get_current_win()
  local current_width = vim.fn.winwidth(0)

  local status_col_width = 5
  local padding_width = current_width - (2 * status_col_width) - tw
  padding_width = math.floor(padding_width / 2)

  return string.rep(" ", padding_width) .. require("snacks.statuscolumn").get()
end

function M.launch_debug_python_shell(pid)
  local dap = require("dap")
  dap.launch(
    {
      type = "executable",
      command = "uv",
      args = { "run", "--with", "debugpy", "python", "-m", "debugpy.adapter", "--pid", pid }
    },
    {
      type = "debugpy",
      request = "launch",
      name = "python_shell",
    },
    {}
  )
end

return M
