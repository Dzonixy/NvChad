local M = {}

-- Remember which toolchains we've already warned about, so the fix message in
-- `server.cmd` below is shown once per toolchain per session, not on every buffer.
local ra_notified = {}

function M.config()
  vim.g.rustaceanvim = {
    tools = {
      hover_actions = {
        auto_focus = false,
      },
      code_actions = {
        ui_select_fallback = true,
      },
      test_executor = "termopen",
      float_win_config = {
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.8),
        max_height = math.floor(vim.o.lines * 0.8),
      },
    },

    server = {
      -- Use rustup's rust-analyzer so it matches whatever toolchain the project
      -- pins via rust-toolchain.toml. Common failure: that toolchain has no
      -- rust-analyzer component, so `rustup which` fails and the LSP silently
      -- never starts. Detect that and print exactly how to fix it.
      cmd = function()
        local ra = vim.trim(vim.fn.system({ "rustup", "which", "rust-analyzer" }))
        if vim.v.shell_error == 0 and ra ~= "" then
          return { ra }
        end

        -- Which toolchain did rustup resolve here? (honors the override)
        local tc = vim.trim(vim.fn.system({ "rustup", "show", "active-toolchain" }))
        tc = tc:match("^(%S+)") or ""

        local key = tc ~= "" and tc or "?"
        if not ra_notified[key] then
          ra_notified[key] = true
          local msg
          if tc ~= "" then
            msg = table.concat({
              "rust-analyzer is not installed for the toolchain this project uses:",
              "    " .. tc,
              "",
              "rustup honors the project's rust-toolchain.toml, and no rust-analyzer",
              "component exists for that toolchain — so the LSP cannot start.",
              "",
              "Fix it:",
              "    rustup component add rust-analyzer --toolchain " .. tc,
              "",
              "Then restart the server:  :RustAnalyzer start   (or <leader>rC)",
            }, "\n")
          else
            msg = table.concat({
              "rust-analyzer could not be resolved via rustup (is rustup on PATH?).",
              "",
              "Inspect the toolchain:  rustup show",
              "Install RA for it:      rustup component add rust-analyzer --toolchain <toolchain>",
            }, "\n")
          end
          vim.notify(msg, vim.log.levels.ERROR, { title = "rustaceanvim: rust-analyzer unavailable" })
        end

        -- Last resort: a rust-analyzer on PATH. Usually the same rustup proxy
        -- (fails identically), but a standalone binary would work here.
        return { "rust-analyzer" }
      end,

      standalone = true,

      default_settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },

          experimental = {
            procAttrMacros = true,
          },

          cachePriming = {
            enable = true,
            numThreads = 10,
          },

          cargo = {
            allFeatures = true,
            buildScripts = {
              enable = true,
            },
          },

          -- Use check (checkOnSave is deprecated)
          check = {
            command = "clippy",
            invocationLocation = "workspace",
            invocationStrategy = "per_workspace",
            allTargets = true,
            features = "all",
          },

          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },

          procMacro = {
            enable = true,
            attributes = {
              enable = true,
            },
            ignored = {
              ["async-trait"] = { "async_trait" },
            },
          },

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

          completion = {
            addCallArgumentSnippets = true,
            addCallParenthesis = true,
            postfix = {
              enable = true,
            },
            autoimport = {
              enable = true,
            },
          },

          workspace = {
            symbol = {
              search = {
                scope = "workspace",
              },
            },
          },

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

          assist = {
            importGranularity = "module",
            importPrefix = "self",
            importGroup = true,
            allowMergingIntoGlobImports = true,
            expressionFillDefault = "todo",
          },

          hover = {
            documentation = {
              enable = true,
            },
            links = {
              enable = true,
            },
          },

          typing = {
            autoClosingAngleBrackets = {
              enable = true,
            },
          },
        },
      },

      on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "<leader>ca", function()
          vim.cmd.RustLsp "codeAction"
        end, "Code Actions")
        map("v", "<leader>ca", function()
          vim.cmd.RustLsp "codeAction"
        end, "Code Actions")

        map("n", "K", function()
          vim.cmd.RustLsp { "hover", "actions" }
        end, "Hover Actions")

        map("n", "<leader>rr", function()
          vim.cmd.RustLsp "runnables"
        end, "Runnables")
        map("n", "<leader>rl", function()
          vim.cmd.RustLsp { "runnables", bang = true }
        end, "Run Last")

        map("n", "<leader>rd", function()
          vim.cmd.RustLsp "debuggables"
        end, "Debuggables")
        map("n", "<leader>rD", function()
          vim.cmd.RustLsp { "debuggables", bang = true }
        end, "Debug Last")

        map("n", "<leader>rt", function()
          vim.cmd.RustLsp "testables"
        end, "Testables")
        map("n", "<leader>rT", function()
          vim.cmd.RustLsp { "testables", bang = true }
        end, "Test Last")

        map("n", "<leader>re", function()
          vim.cmd.RustLsp "expandMacro"
        end, "Expand Macro")

        map("n", "<leader>rc", function()
          vim.cmd.RustLsp "openCargo"
        end, "Open Cargo.toml")

        map("n", "<leader>rp", function()
          vim.cmd.RustLsp "parentModule"
        end, "Parent Module")

        map("n", "<leader>rj", function()
          vim.cmd.RustLsp "joinLines"
        end, "Join Lines")
        map("v", "<leader>rj", function()
          vim.cmd.RustLsp "joinLines"
        end, "Join Lines")

        map("n", "<leader>rs", function()
          vim.cmd.RustLsp "ssr"
        end, "Structural Search Replace")

        map("n", "<leader>rh", function()
          vim.cmd.RustLsp { "view", "hir" }
        end, "View HIR")

        map("n", "<leader>rm", function()
          vim.cmd.RustLsp { "view", "mir" }
        end, "View MIR")

        map("n", "<leader>rex", function()
          vim.cmd.RustLsp "explainError"
        end, "Explain Error")

        map("n", "<leader>rdc", function()
          vim.cmd.RustLsp "renderDiagnostic"
        end, "Render Diagnostic")

        map("n", "<leader>rf", function()
          vim.cmd.RustLsp { "flyCheck", "run" }
        end, "Run Fly Check")
        map("n", "<leader>rF", function()
          vim.cmd.RustLsp { "flyCheck", "cancel" }
        end, "Cancel Fly Check")
      end,
    },

    dap = {
      autoload_configurations = true,
    },
  }

  -- Global keymaps
  vim.keymap.set("n", "<leader>rC", function()
    vim.cmd "RustAnalyzer stop"
    vim.cmd "RustAnalyzer start"
  end, { desc = "Restart Rust Analyzer" })

  -- Reload workspace on Cargo.toml save (only if rust-analyzer is running)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("RustaceanvimConfig", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
      local clients = vim.lsp.get_clients { name = "rust-analyzer" }
      if #clients > 0 then
        vim.cmd.RustLsp { "reloadWorkspace" }
      end
    end,
  })
end

return M
