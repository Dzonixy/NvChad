local options = {
  ensure_installed = {
    "bash",
    "fish",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "printf",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "typescript",
    "rust",
    "json",
    "jsonc",
    "sql",
    "javascript",
    "tsx",
    "html",
    "css",
    "c",
    "cpp",
    "cmake",
    "make",
    "doxygen",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
