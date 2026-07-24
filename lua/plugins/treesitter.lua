return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- 0.12+ rewrite; `master` is frozen and errors on Neovim 0.12
  lazy = false, -- the `main` branch explicitly does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    require "configs.treesitter"
  end,
}
