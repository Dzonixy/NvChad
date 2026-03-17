local ensure_installed = {
  "lua_ls",
  "gopls",
  "ts_ls",
  "html",
  "cssls",
  "taplo",
  "jsonls",
  "yamlls",
  "sqls",
  "bashls",
}

require("mason-lspconfig").setup {
  ensure_installed = ensure_installed,
  automatic_installation = true,
  automatic_enable = {
    exclude = { "rust_analyzer" }, -- rustaceanvim manages rust-analyzer
  },
}
