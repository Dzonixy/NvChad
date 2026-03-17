-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  cmp = {
    icons_left = true,
    style = "atom_colored",
  },

  telescope = { style = "bordered" },

  statusline = {
    theme = "minimal",
    separator_style = "round",
  },

  tabufline = {
    lazyload = true,
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    "                                   ",
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆         ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠶⣿⠿⣿⣿⣿⣿⣶⣦⠤⠶⠶⠶⢿⣿⣿⣿⣿⣿⠿⣿  ",
    "    ⠛⠒ ⣿⣿⠉⠿⣿⣿⣿   ⣿⣿⠉⠛⣿⣿⣿⣿    ⣿⠉⠿⣿⣿⣿⣿⣿  ",
    "      ⣿⣿    ⠈    ⣿⣿    ⠈       ⣿⣿      ",
    "      ⣿⣿             ⣿⣿              ",
    "                                   ",
    "       N E O V I M                  ",
    "                                   ",
  },
}

M.lsp = { signature = true }

M.colorify = {
  enabled = true,
  mode = "virtual",
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

return M
