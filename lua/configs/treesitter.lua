-- nvim-treesitter `main` branch (Neovim 0.12+ rewrite).
--
-- The old `master` API is gone: there is no
-- `require("nvim-treesitter.configs").setup{ ensure_installed, highlight, indent }`.
-- On `main` you install parsers explicitly and turn highlight/indent on per-buffer
-- via a FileType autocmd. Parsers are compiled locally, so this needs the
-- `tree-sitter` CLI (>=0.26.1) and a C compiler on PATH.

local ts = require "nvim-treesitter"

ts.setup {
  -- Default location, already on the runtimepath. Made explicit for clarity.
  install_dir = vim.fn.stdpath "data" .. "/site",
}

-- Parsers we want kept installed. `install()` is async and idempotent — for
-- parsers already present it is a no-op, so running it on startup just backfills
-- anything missing (e.g. a newly-added language).
local parsers = {
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
}

ts.install(parsers)

-- `jsonc` has no standalone grammar on the `main` branch; point the jsonc
-- filetype at the `json` parser so those buffers still get tree-sitter highlighting.
vim.treesitter.language.register("json", "jsonc")

-- Turn on tree-sitter highlighting (+ experimental indentation) for every buffer
-- whose filetype has a parser. `vim.treesitter.start()` raises when no parser is
-- available for the filetype, so guard it with pcall and let those buffers fall
-- back to classic Vim syntax highlighting.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
