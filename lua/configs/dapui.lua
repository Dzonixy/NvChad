local M = {}

function M.setup()
  local dapui = require "dapui"
  local dap = require "dap"

  dapui.setup {
    floating = {
      border = "rounded",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        position = "left",
        size = 40,
      },
      {
        elements = {
          { id = "repl", size = 0.5 },
          { id = "console", size = 0.5 },
        },
        position = "bottom",
        size = 10,
      },
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
