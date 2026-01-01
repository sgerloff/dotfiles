local keymaps = require("lazy.config.keymaps")
vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    group = vim.api.nvim_create_augroup( "UserLspConfig", {}),
    callback = function(event)
      local nmap = function(mode, keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        if not mode then
          mode = "n"
        end

        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
      end

      for _, key in ipairs(keymaps.LazyPluginKeys["lsp_on_attach"]) do
        nmap(key.mode, key[1], key[2], key.desc)
      end
    end,
  }
)
