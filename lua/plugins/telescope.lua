return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "folke/trouble.nvim" },
  opts = function(_, opts)
    local open_with_trouble = require("trouble.sources.telescope").open
    opts.defaults = opts.defaults or {}
    opts.defaults.mappings = opts.defaults.mappings or {}
    opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i or {}, {
      ["<c-t>"] = open_with_trouble,
    })
    opts.defaults.mappings.n = vim.tbl_extend("force", opts.defaults.mappings.n or {}, {
      ["<c-t>"] = open_with_trouble,
    })
    return opts
  end,
}
