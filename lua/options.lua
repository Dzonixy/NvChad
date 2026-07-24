require "nvchad.options"

local o = vim.o

-- cursor
o.cursorlineopt = "both"
o.cursorline = true

-- line numbers
o.relativenumber = true
o.number = true

-- smoother UI
o.termguicolors = true
o.signcolumn = "yes"
o.scrolloff = 8
o.sidescrolloff = 8

-- splits open in natural directions
o.splitbelow = true
o.splitright = true

-- better search
o.ignorecase = true
o.smartcase = true

-- persistent undo
o.undofile = true

-- rounded borders on all floating windows
vim.diagnostic.config {
  float = { border = "rounded" },
}
-- Neovim 0.11+ native default border for every floating window (LSP hover,
-- signature help, completion docs, etc.). Replaces the old
-- vim.lsp.handlers + vim.lsp.with() wrapping, which 0.12 removed.
vim.o.winborder = "rounded"
