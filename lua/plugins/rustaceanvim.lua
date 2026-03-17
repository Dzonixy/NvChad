return {
  "mrcjkb/rustaceanvim",
  version = "^8",
  lazy = false, -- plugin is already lazy by design (uses ftplugin)
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  init = function()
    -- vim.g.rustaceanvim must be set BEFORE the plugin loads
    require("configs.rustaceanvim").config()
  end,
}
