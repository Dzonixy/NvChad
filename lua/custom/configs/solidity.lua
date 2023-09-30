local lspconfig = require "lspconfig"
local on_attach = require("custom.configs.lspconfig").on_attach
local capabilities = require("custom.configs.lspconfig").capabilities

lspconfig.solidity.setup {
  on_attach = on_attach, -- probably you will need this.
  capabilities = capabilities,
  settings = {
    -- example of global remapping
    solidity = { includePath = "", remapping = { ["@OpenZeppelin/"] = "OpenZeppelin/openzeppelin-contracts@4.6.0/" } },
  },
}
