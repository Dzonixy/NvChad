-- require("dap-vscode-js").setup {
--   debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
--   debugger_cmd = { "js-debug-adapter" },
--   adapters = { "pwa-node" },
-- }
--
-- local dap = require "dap"
--
-- local custom_adapter = "pwa-node-custom"
-- dap.adapters[custom_adapter] = function(cb, config)
--   if config.preLaunchTask then
--     local async = require "plenary.async"
--     local notify = require("notify").async
--
--     async.run(function()
--       notify("Running [" .. config.preLaunchTask .. "]").events.close()
--     end, function()
--       vim.fn.system(config.preLaunchTask)
--       config.type = "pwa-node"
--       dap.run(config)
--     end)
--   end
-- end
--
-- for _, language in ipairs { "typescript", "javascript" } do
--   dap.configurations[language] = {
--     {
--       name = "Launch",
--       type = "pwa-node",
--       request = "launch",
--       program = "${workspaceFolder}/src/main.ts", -- Ensure this points to the main entry of your Nest.js app
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       sourceMaps = true,
--       skipFiles = { "<node_internals>/**" },
--       protocol = "inspector",
--       console = "integratedTerminal",
--       port = 9229, -- Set the debug port explicitly to 9229
--     },
--
--     {
--       name = "Attach to node process",
--       type = "pwa-node",
--       request = "attach",
--       rootPath = "${workspaceFolder}",
--       processId = require("dap.utils").pick_process,
--       port = 9229, -- Set the debug port explicitly to 9229
--     },
--   }
-- end
--
-- vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
-- require("dap-vscode-js").setup {
--   debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
--   debugger_cmd = { "js-debug-adapter" },
--   adapters = { "pwa-node" },
-- }
--
-- local dap = require "dap"
--
-- dap.configurations.javascript = {
--   {
--     name = "Launch",
--     type = "pwa-node",
--     request = "launch",
--     program = "${workspaceFolder}/src/main.ts", -- adjust path to your Nest.js entry file
--     rootPath = "${workspaceFolder}",
--     cwd = "${workspaceFolder}",
--     sourceMaps = true,
--     skipFiles = { "<node_internals>/**" },
--     protocol = "inspector",
--     console = "integratedTerminal",
--   },
--   {
--     name = "Attach to node process",
--     type = "pwa-node",
--     request = "attach",
--     rootPath = "${workspaceFolder}",
--     processId = require("dap.utils").pick_process,
--   },
-- }
--
-- dap.adapters.node2 = {
--   type = "executable",
--   command = "node",
--   args = { require("dap-vscode-js").debugger_path .. "/out/src/nodeDebug.js" },
-- }
local dap = require "dap"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  },
}

for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
      sourceMaps = true,
      protocol = "inspector",
      -- console = "integratedTerminal",
    },
  }
end
