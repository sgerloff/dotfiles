local utils = require("lazy.config.utils")
return {
  on_init = function(client)
    client.config.settings.pythonPath = utils.get_python_path()
  end,
  settings = {
    python = {
      pyrefly = {
        displayTypeErrors = "force-on",
      },
    }
  },
}
