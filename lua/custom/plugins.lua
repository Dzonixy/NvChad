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
    ft = {
      "go",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "lua",
      "sh",
      "yaml",
      "sql",
    },
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

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          require("dap-vscode-js").setup {
            debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"),
            adapters = { "chrome", "pwa-node", "pwa-chrome", "node-terminal", "node" },
          }
        end,
      },
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      require "custom.configs.dap"
      require("core.utils").load_mappings "dap"
    end,
  },

  {
    "LiadOz/nvim-dap-repl-highlights",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      if not require("nvim-treesitter.parsers").has_parser "dap_repl" then
        vim.cmd ":TSInstall dap_repl"
      end
    end,
  },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    run = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
        },
      }
    end,
  },
}
return plugins
