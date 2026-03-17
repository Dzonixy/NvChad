return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = require "configs.copilot",
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    lazy = false,
    config = function()
      require("copilot_cmp").setup {}
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    lazy = false,
    build = "make tiktoken",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
    },
    opts = require("configs.copilot-chat").config(),
    keys = {
      { "<leader>cb", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Chat with current buffer" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "CopilotChat - Fix code" },
    },
  },
}
