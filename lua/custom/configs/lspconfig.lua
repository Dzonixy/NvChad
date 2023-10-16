local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  init_options = {
    disableSuggestions = true,
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.mod", ".git", "go.work"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.move_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "move" },
  root_dir = util.root_pattern "Move.toml",
}
