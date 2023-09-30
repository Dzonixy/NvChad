local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensures_installed = {
        "rust-analyzer",
        "move-analyzer",
        "tsserver",
        "shfmt",
        "gopls",
        "solidity-ls",
        "eslint-lsp",
        "shellcheck",
        "sqls",
        "stylua",
        "prettierd",
        "prettier",
        "sql-formatter",
        "yaml-language-server",
        "eslint_d",
        "js-debug-adapter",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "rust",
      },
      width = function(_, cols, _)
        if cols > 200 then
          return 170
        else
          return math.floor(cols * 0.87)
        end
      end,
    },
  },

  {
    "nvimtools/none-ls.nvim",
    ft = { "go", "typescript", "javascript", "lua", "sh", "yaml", "sql" },
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {}
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  {
    "rvmelkonian/move.vim",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = "move",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "typescript",
        "rust",
      },
    },
  },

  {
    "z0mbix/vim-shfmt",
    ft = "sh",
    init = function()
      vim.g.shfmt_fmt_on_save = 1
    end,
  },

  {
    "sql-formatter-org/sql-formatter",
    ft = "sql",
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = require "custom.configs.copilot",
    config = function(opts)
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "zbirenbaum/copilot-cmp" },
    },
    after = { "copilot-cmp" },
    opts = {
      sources = {
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
      },
    },
  },

  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
  },

  {
    "qiuxiang/solidity-ls",
    ft = { "solidity" },
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.dap"
      require("core.utils").load_mappings "dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
return plugins
