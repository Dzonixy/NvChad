local overrides = require "custom.configs.overrides"

local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensures_installed = {
        "rust-analyzer",
        "move-analyzer",
        "tsserver",
        "shfmt"
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim"
    },
    config = function ()
      require "custom.configs.lspconfig"
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function ()
      require "custom.configs.null-ls"
    end
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = "typescript",
    opts = function ()
      return require "custom.configs.typescript-tools"
    end,
    config = function (_, opts)
      require('typescript-tools').setup(opts)
    end
  },

  {
    "sbdchd/neoformat",
    ft = "typescript",
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {"neovim/nvim-lspconfig"},
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end,
  },

  {
    'rvmelkonian/move.vim',
    dependencies = { "neovim/nvim-lspconfig" },
    ft = "move",
  },

  {
    "mfussenegger/nvim-dap",
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
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
    'ray-x/guihua.lua',
    run = 'cd lua/fzy && make'
  },

  {
   "ray-x/navigator.lua",
    dependencies = {
      "neovim/nvim-lspconfig",
      'ray-x/guihua.lua'
    },
    config = function (_, opts)
      require('navigator').setup(opts)
    end
  },

  {
    "junegunn/goyo.vim",
    ft = "markdown",
  },

  {
    'lervag/vimtex',
  },

  {
    'z0mbix/vim-shfmt',
    ft = 'sh',
    init = function ()
      vim.g.shfmt_fmt_on_save = 1
    end,
  },

  {
    "sql-formatter-org/sql-formatter",
    ft = "sql",
    config = function (_, opts)
      require('sql-fmt').setup(opts)
    end
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    -- event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot.lua"
    },
    lazy = false,
    opts = overrides,
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {"zbirenbaum/copilot-cmp"},
    },
    after = { "copilot-cmp" },
    opts = {
      sources = {
        { name = "copilot",  group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
      },
    },
  },

  {
    "cuducos/yaml.nvim",
    ft = {"yaml"},
    config = function ()
      require("yaml").setup()
    end
  },

  {
    "qiuxiang/solidity-ls",
    ft = {"solidity"}
  },
}
return plugins

