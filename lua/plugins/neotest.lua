return {
  { "nvim-neotest/nvim-nio" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "fredrikaverpil/neotest-golang",
      "leoluz/nvim-dap-go",
      "mrcjkb/rustaceanvim",
    },
    config = function()
      local base_opts = require("configs.neotest").config()
      -- Add rustaceanvim adapter (must be required after plugin loads)
      table.insert(base_opts.adapters, require "rustaceanvim.neotest")
      require("neotest").setup(base_opts)
    end,
  },
}
