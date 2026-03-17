return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  opts = {
    completion = {
      cmp = {
        enabled = true,
      },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
  keys = {
    { "<leader>cu", function() require("crates").upgrade_all_crates() end, desc = "Update All Crates" },
    { "<leader>cU", function() require("crates").upgrade_crate() end, desc = "Update Crate" },
    { "<leader>ci", function() require("crates").show_crate_popup() end, desc = "Crate Info" },
    { "<leader>cv", function() require("crates").show_versions_popup() end, desc = "Crate Versions" },
    { "<leader>cf", function() require("crates").show_features_popup() end, desc = "Crate Features" },
    { "<leader>cd", function() require("crates").show_dependencies_popup() end, desc = "Crate Dependencies" },
  },
}
