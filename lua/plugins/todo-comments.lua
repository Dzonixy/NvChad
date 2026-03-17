return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "User FilePost",
  opts = {},
  keys = {
    {
      "]T",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next TODO Comment",
    },
    {
      "[T",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous TODO Comment",
    },
    { "<leader>tT", "<cmd>Trouble todo toggle<cr>", desc = "TODO Comments (Trouble)" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODO Comments" },
  },
}
