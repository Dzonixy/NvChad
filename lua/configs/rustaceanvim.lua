local M = {}

function M.config()
  -- Configure rustaceanvim here
  vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
      -- Enable hover actions
      hover_actions = {
        -- Whether to automatically focus the hover popup window
        auto_focus = false,
      },

      -- Options for displaying code actions
      code_actions = {
        -- Fallback to vim.ui.select if there are no grouped code actions
        ui_select_fallback = true,
      },

      -- Test execution backend
      test_executor = "termopen", -- Can be 'termopen', 'background' or 'neotest'

      -- Options for floating windows
      float_win_config = {
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.8),
        max_height = math.floor(vim.o.lines * 0.8),
      },
    },

    -- LSP server configuration
    server = {
      -- Standalone file support (enabled if inside a cargo project)
      standalone = true,

      -- rust-analyzer settings
      default_settings = {
        ["rust-analyzer"] = {
          -- Import settings
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },

          -- Cargo settings
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },

          -- Check on save settings (use clippy)
          checkOnSave = {
            command = "clippy",
            -- extraArgs = { "--", "-W", "clippy::pedantic", "-W", "clippy::nursery" },
          },

          -- Diagnostics settings
          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },

          -- Proc macro settings
          procMacro = {
            enable = true,
            -- ignored = {
            --   ["async-trait"] = { "async_trait" },
            --   ["napi-derive"] = { "napi" },
            --   ["async-recursion"] = { "async_recursion" },
            -- },
          },

          -- Inlay hints settings (for Neovim 0.10+)
          inlayHints = {
            bindingModeHints = {
              enable = true,
            },
            chainingHints = {
              enable = true,
            },
            closingBraceHints = {
              enable = true,
              minLines = 25,
            },
            closureReturnTypeHints = {
              enable = "never",
            },
            lifetimeElisionHints = {
              enable = "never",
              useParameterNames = false,
            },
            maxLength = 25,
            parameterHints = {
              enable = true,
            },
            reborrowHints = {
              enable = "never",
            },
            renderColons = true,
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
          },

          -- Workspace settings
          workspace = {
            symbol = {
              search = {
                scope = "workspace",
              },
            },
          },

          -- Files to exclude
          files = {
            excludeDirs = {
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
          },
        },
      },

      -- on_attach function
      on_attach = function(client, bufnr)
        -- Set up buffer-local keymaps here
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Code actions
        map("n", "<leader>ca", function()
          vim.cmd.RustLsp "codeAction"
        end, "Code Actions")
        map("v", "<leader>ca", function()
          vim.cmd.RustLsp "codeAction"
        end, "Code Actions")

        -- Hover actions
        map("n", "K", function()
          vim.cmd.RustLsp { "hover", "actions" }
        end, "Hover Actions")

        -- Runnables
        map("n", "<leader>rr", function()
          vim.cmd.RustLsp "runnables"
        end, "Runnables")
        map("n", "<leader>rl", function()
          vim.cmd.RustLsp { "runnables", bang = true }
        end, "Run Last")

        -- Debuggables
        map("n", "<leader>rd", function()
          vim.cmd.RustLsp "debuggables"
        end, "Debuggables")
        map("n", "<leader>rD", function()
          vim.cmd.RustLsp { "debuggables", bang = true }
        end, "Debug Last")

        -- Testables
        map("n", "<leader>rt", function()
          vim.cmd.RustLsp "testables"
        end, "Testables")
        map("n", "<leader>rT", function()
          vim.cmd.RustLsp { "testables", bang = true }
        end, "Test Last")

        -- Expand macro
        map("n", "<leader>re", function()
          vim.cmd.RustLsp "expandMacro"
        end, "Expand Macro")

        -- Open Cargo.toml
        map("n", "<leader>rc", function()
          vim.cmd.RustLsp "openCargo"
        end, "Open Cargo.toml")

        -- Parent module
        map("n", "<leader>rp", function()
          vim.cmd.RustLsp "parentModule"
        end, "Parent Module")

        -- Join lines
        map("n", "<leader>rj", function()
          vim.cmd.RustLsp "joinLines"
        end, "Join Lines")
        map("v", "<leader>rj", function()
          vim.cmd.RustLsp "joinLines"
        end, "Join Lines")

        -- Structural search replace
        map("n", "<leader>rs", function()
          vim.cmd.RustLsp "ssr"
        end, "Structural Search Replace")

        -- View HIR
        map("n", "<leader>rh", function()
          vim.cmd.RustLsp { "view", "hir" }
        end, "View HIR")

        -- View MIR
        map("n", "<leader>rm", function()
          vim.cmd.RustLsp { "view", "mir" }
        end, "View MIR")

        -- Explain error
        map("n", "<leader>rex", function()
          vim.cmd.RustLsp "explainError"
        end, "Explain Error")

        -- Render diagnostics
        map("n", "<leader>rdc", function()
          vim.cmd.RustLsp "renderDiagnostic"
        end, "Render Diagnostic")

        -- Fly check
        map("n", "<leader>rf", function()
          vim.cmd.RustLsp { "flyCheck", "run" }
        end, "Run Fly Check")
        map("n", "<leader>rF", function()
          vim.cmd.RustLsp { "flyCheck", "cancel" }
        end, "Cancel Fly Check")
      end,
    },

    -- DAP (Debug Adapter Protocol) configuration
    dap = {
      -- Automatically generate and load DAP configurations
      autoload_configurations = true,

      -- Configuration will be automatically set if codelldb is detected
      -- You can also manually specify the adapter
      -- adapter = {
      --   type = "executable",
      --   command = "codelldb",
      --   args = { "--port", "${port}" },
      -- },
    },
  }

  -- Additional helper functions
  M.setup_keymaps = function()
    -- Global keymaps that are always available
    vim.keymap.set("n", "<leader>rC", function()
      vim.cmd "RustAnalyzer stop"
      vim.cmd "RustAnalyzer start"
    end, { desc = "Restart Rust Analyzer" })
  end

  -- Set up autocmds
  M.setup_autocmds = function()
    local group = vim.api.nvim_create_augroup("RustaceanvimConfig", { clear = true })

    -- Format on save with rustfmt
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = "*.rs",
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })

    -- Automatically reload workspace on Cargo.toml changes
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = group,
      pattern = "Cargo.toml",
      callback = function()
        vim.cmd.RustLsp { "reloadWorkspace" }
      end,
    })
  end

  -- Call setup functions
  M.setup_keymaps()
  M.setup_autocmds()
end

-- Function to check health
M.check_dependencies = function()
  local dependencies = {
    { cmd = "rust-analyzer", name = "rust-analyzer" },
    { cmd = "rustc", name = "Rust compiler" },
    { cmd = "cargo", name = "Cargo" },
  }

  for _, dep in ipairs(dependencies) do
    if vim.fn.executable(dep.cmd) == 0 then
      vim.notify(dep.name .. " not found in PATH!", vim.log.levels.WARN)
    end
  end
end

return M
