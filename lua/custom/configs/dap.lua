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
      name = "Debug NestJS Server",
      runtimeExecutable = "npm",
      runtimeArgs = { "run", "start:dev" },
      program = "${workspaceFolder}/src/main.ts", -- Assuming 'main.ts' is in the 'src' folder
      cwd = "${workspaceFolder}",
      outputCapture = "std",
      sourceMaps = true,
      console = "integratedTerminal", -- This can be helpful for seeing log output
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
      sourceMaps = true,
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process",
      processId = "${command:PickProcess}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
      sourceMaps = true,
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch & Debug Chrome",
      url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({
            prompt = "URL: ",
            default = "http://localhost:3000",
          }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end,
      webRoot = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**/*.js" },
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
    },
  }
end
