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
    }
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim"
    },
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function ()
      require("null-ls").setup()
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
    config = function ()
      require('rust-tools').setup()
    end,
  },

  {
    'rvmelkonian/move.vim',
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
    'z0mbix/vim-shfmt',
    ft = 'sh',
    init = function ()
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
    -- event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua"
    },
    lazy = false,
    opts = overrides.copilot,
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

