return {
  "mrcjkb/rustaceanvim",
  version = "^9", -- v9 requires Neovim 0.12 (v8 was the last 0.11-compatible line)
  lazy = false, -- plugin is already lazy by design (uses ftplugin)
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  init = function()
    -- vim.g.rustaceanvim must be set BEFORE the plugin loads
    require("configs.rustaceanvim").config()
  end,
}
