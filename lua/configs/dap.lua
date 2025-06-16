local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  -- Configure Mason-DAP
  require("mason-nvim-dap").setup {
    automatic_installation = true,
    ensure_installed = { "delve", "codelldb" },
    enabled = true,
    enable_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = "<module",
    virt_text_pos = "eol",
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
  }

  require("dap-go").setup()

  local dapui = require "dapui"
  dap.listeners.after.event_initialized["dapui"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui"] = function()
    dapui.close()
  end
end

return M
