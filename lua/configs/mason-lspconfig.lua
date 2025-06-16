local ensure_installed = {
  "lua_ls",
  "gopls",
  "ts_ls",
  "html",
  "cssls",
}

require("mason-lspconfig").setup {
  ensure_installed = ensure_installed,
  automatic_installation = true,
}
