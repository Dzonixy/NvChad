local M = {}

function M.setup()
  local dapui = require "dapui"

  dapui.setup {
    refresh = {
      delay = 300,
      mode = "auto",
    },
  }

  vim.api.nvim_create_user_command("DapUiClose", function()
    require("dapui").close()
  end, {})

  vim.api.nvim_create_user_command("DapUiReset", function()
    require("dapui").toggle { reset = true }
    require("dapui").toggle { reset = true }
  end, {})
end

return M
