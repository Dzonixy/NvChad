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
    ["<F5>"] = {
      "<cmd>lua require 'dap'.continue()<CR>",
      "Continue execution",
    },
    ["<F10>"] = {
      "<cmd>lua require 'dap'.step_over()<CR>",
      "Step over",
    },
    ["<F11>"] = {
      "<cmd>lua require 'dap'.step_into()<CR>",
      "Step into",
    },
    ["<F12>"] = {
      "<cmd>lua require 'dap'.step_out()<CR>",
      "Step out",
    },
    ["<leader>b"] = {
      "<cmd>lua require 'dap'.toggle_breakpoint()<CR>",
      "Toggle breakpoint",
    },
    ["<leader>B"] = {
      "<cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "Set breakpoint with condition",
    },
  },
}
return M
