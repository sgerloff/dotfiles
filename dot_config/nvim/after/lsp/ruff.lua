local utils = require("lazy.config.utils")
return {
  on_init = function(client)
    client.config.settings.args.interpreter = utils.get_python_path()
  end,
  settings = { args = {} },
}
