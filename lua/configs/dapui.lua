local M = {}

function M.setup()
  local dapui = require "dapui"
  local dap = require "dap"

  dapui.setup {
    refresh = {
      delay = 300,
      mode = "auto",
    },
  }

  -- Set up DAP listeners here instead of in dap.lua
  dap.listeners.after.event_initialized["dapui"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui"] = function()
    dapui.close()
  end

  vim.api.nvim_create_user_command("DapUiClose", function()
    require("dapui").close()
  end, {})

  vim.api.nvim_create_user_command("DapUiReset", function()
    require("dapui").toggle { reset = true }
  end, {})
end

return M
