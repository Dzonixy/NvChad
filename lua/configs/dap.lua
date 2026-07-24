local M = {}

function M.setup()
  local dap = require "dap"

  -- Sign icons for breakpoints
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

  -- Configure Mason-DAP first to ensure adapters are set up
  require("mason-nvim-dap").setup {
    automatic_installation = true,
    ensure_installed = { "delve", "codelldb", "js-debug-adapter" },
    handlers = {
      function(config)
        -- all sources with no handler get passed here
        require("mason-nvim-dap").default_setup(config)
      end,
      -- You can provide targeted overrides for specific adapters
      js = function(config)
        config.adapters = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
        require("mason-nvim-dap").default_setup(config) -- don't forget this!
      end,
    },
  }

  -- mason-nvim-dap's automatic codelldb setup leaves the adapter command empty on
  -- the current mason.nvim (it can't resolve the package path), which silently
  -- breaks Rust and C/C++ debugging (both use type = "codelldb"). Point the
  -- adapter at the installed binary explicitly.
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },
    },
  }

  -- Additional adapter configurations
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {
        vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    },
  }

  dap.adapters["pwa-chrome"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {
        vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    },
  }

  -- Node.js/TypeScript configurations
  for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Mocha Tests",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/mocha/bin/mocha",
          "--inspect-brk",
          "--recursive",
          "--timeout",
          "999999",
          "--colors",
          "${workspaceFolder}/test/**/*.test.js",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Chrome",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
    }
  end

  -- C/C++ configurations (uses codelldb, same adapter as Rust)
  for _, language in ipairs { "c", "cpp" } do
    dap.configurations[language] = {
      {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          local input = vim.fn.input "Arguments: "
          return vim.split(input, " ", { trimempty = true })
        end,
      },
      {
        name = "Launch executable (with build)",
        type = "codelldb",
        request = "launch",
        program = function()
          -- Build first, then ask for executable
          local build_cmd = vim.fn.input("Build command (empty to skip): ", "make")
          if build_cmd ~= "" then
            vim.fn.system(build_cmd)
          end
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end

  -- Go configurations are handled by dap-go
  require("dap-go").setup()
end

return M
