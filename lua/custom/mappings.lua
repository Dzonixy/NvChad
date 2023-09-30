local M = {}

M.neo = {
  n = {
    ["<M-j>"] = { "<cmd> m .+1<CR>==", "Move line down(n)" },
    ["<M-k>"] = { "<cmd> m .-2<CR>==", "Move line up(n)" },
    [";"] = { ":", "skiping pressing shift" },
  },
  v = {
    ["<M-k>"] = { "<cmd> m <-2<CR>gv=gv", "Move line up(n)" },
    ["<M-j>"] = { "<cmd> m >+1<CR>gv=gv", "Move line down(n)" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint<CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue<CR>",
      "Run or continue the debugger",
    },
  },
}
return M
