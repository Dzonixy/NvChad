return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    auto_close = true,
    focus = true,
    follow = true,
    indent_guides = true,
    multiline = true,
    warn_no_results = true,
    open_no_results = false,
    icons = {
      indent = {
        last = "╰╴", -- rounded to match minimal+round statusline
      },
    },
    modes = {
      symbols = {
        desc = "document symbols",
        mode = "lsp_document_symbols",
        focus = false,
        win = { position = "right" },
        filter = {
          ["not"] = { ft = "lua", kind = "Package" },
          any = {
            ft = { "help", "markdown" },
            kind = {
              "Class",
              "Constructor",
              "Enum",
              "Field",
              "Function",
              "Interface",
              "Method",
              "Module",
              "Namespace",
              "Package",
              "Property",
              "Struct",
              "Trait",
            },
          },
        },
      },
    },
  },
  keys = {
    -- Diagnostics
    {
      "<leader>tx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>tX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },

    -- Symbols
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },

    -- LSP
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>td",
      "<cmd>Trouble lsp_definitions toggle<cr>",
      desc = "LSP Definitions (Trouble)",
    },
    {
      "<leader>tr",
      "<cmd>Trouble lsp_references toggle<cr>",
      desc = "LSP References (Trouble)",
    },
    {
      "<leader>ti",
      "<cmd>Trouble lsp_implementations toggle<cr>",
      desc = "LSP Implementations (Trouble)",
    },
    {
      "<leader>tt",
      "<cmd>Trouble lsp_type_definitions toggle<cr>",
      desc = "LSP Type Definitions (Trouble)",
    },

    -- Lists
    {
      "<leader>tL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>tQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },

    -- Navigate items from any buffer
    {
      "]t",
      function()
        require("trouble").next { skip_groups = true, jump = true }
      end,
      desc = "Next Trouble Item",
    },
    {
      "[t",
      function()
        require("trouble").prev { skip_groups = true, jump = true }
      end,
      desc = "Previous Trouble Item",
    },
  },
}
