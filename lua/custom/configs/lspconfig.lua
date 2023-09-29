local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"typescript, javascript"},
})

lspconfig.move_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"move"},
  root_dir = util.root_pattern("Move.toml"),
})

