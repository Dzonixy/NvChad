local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  tools = {
    autoSetHints = true,
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
    },
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
}
return options
