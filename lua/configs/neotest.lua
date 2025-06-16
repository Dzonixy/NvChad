local M = {}

function M.config()
  return {
    adapters = {
      ["neotest-golang"] = {
        dap_go_enabled = true, -- requires leoluz/nvim-dap-go
      },
    },
  }
end

return M
