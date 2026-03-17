require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "gopls", "lua_ls", "taplo", "jsonls", "yamlls", "sqls", "bashls" }
vim.lsp.enable(servers)

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        enable = false,
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

vim.lsp.config('gopls', {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})

vim.lsp.config('ts_ls', {
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
})

vim.lsp.config('taplo', {
  filetypes = { "toml" },
  root_markers = { ".git", "Cargo.toml" },
  settings = {
    taplo = {
      formatting = {
        alignEntries = false,
        arrayAutoCollapse = true,
        arrayAutoExpand = true,
        arrayTrailingComma = true,
        columnWidth = 80,
        reorderKeys = true,
      },
    },
  },
})

vim.lsp.config('jsonls', {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("configs.json-schemas").schemas(),
    },
  },
})

vim.lsp.config('yamlls', {
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  settings = {
    yaml = {
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {},
      format = { enable = false }, -- conform handles formatting
      hover = true,
      completion = true,
    },
  },
})

vim.lsp.config('sqls', {
  filetypes = { "sql", "mysql", "plsql" },
  root_markers = { ".git" },
})

vim.lsp.config('bashls', {
  filetypes = { "sh", "bash", "zsh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },
})

