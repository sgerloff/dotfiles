local M = {}

--- Map a list of keybindings with a standardized structure.
--- Uses Snacks.keymap.set for ft/lsp/enabled support.
--- Each entry: { lhs, rhs, mode = ..., desc = ..., buffer = ..., expr = ..., nowait = ..., ft = ..., lsp = ..., enabled = ... }
--- @param keys table[] List of key definition tables
--- @param opts? table Optional overrides (e.g. { buffer = bufnr, lsp = {} })
function M.map_keys(keys, opts)
  opts = opts or {}
  for _, key in ipairs(keys) do
    local lhs = key[1]
    local rhs = key[2]
    local mode = key.mode or "n"
    local map_opts = {
      desc = key.desc,
      buffer = opts.buffer or key.buffer,
      silent = key.silent ~= false,
      expr = key.expr,
      nowait = key.nowait,
      remap = key.remap,
      ft = key.ft or opts.ft,
      lsp = key.lsp or opts.lsp,
      enabled = key.enabled,
    }
    Snacks.keymap.set(mode, lhs, rhs, map_opts)
  end
end

--- Returns a dot repeatable version of a function to be used in keymaps.
--- Setting expr = true in the keymap is required for this to work.
function M.dot_repeat(callback)
  return function()
    _G.dot_repeat_callback = callback
    vim.go.operatorfunc = "v:lua.dot_repeat_callback"
    return "g@l"
  end
end

--- Get the Python path from VIRTUAL_ENV, .venv, or fallback to host prog.
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
    venv_path = vim.fn.fnamemodify(venv_path, ":p")
    return venv_path
  else
    return vim.g.python3_host_prog
  end
end

--- Infer the best Python shell (ipython if available, else python).
function M.infer_python_shell()
  local venv_path = M.get_python_path()
  if venv_path == nil then
    return "python"
  end

  local potential_ipython_path = venv_path:gsub("/python$", "/ipython")
  if vim.fn.filereadable(potential_ipython_path) == 1 then
    return potential_ipython_path
  end
  if vim.fn.filereadable(venv_path) == 1 then
    return venv_path
  end
  return "python"
end

--- Open a floating dap-ui element.
function M.dapui_float_element(element_id, size)
  local width = math.floor(vim.o.columns * size)
  local height = math.floor(vim.o.lines * size)
  require("dapui").float_element(element_id, {
    width = width,
    height = height,
    enter = true,
    position = "center",
  })
end

--- Toggle a scratch window (snacks-based).
M.__scratch_win = nil

function M.toggle_scratch_win()
  if M.__scratch_win and M.__scratch_win:valid() then
    M.__scratch_win:toggle()
  else
    M.__scratch_win = require("snacks").win({
      scratch_ft = "markdown",
      position = "left",
      width = 0.15,
      height = 1,
      fixbuf = true,
      enter = false,
      minimal = true,
      wo = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        wrap = false,
      },
    })
  end
end

return M
