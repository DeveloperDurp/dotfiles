require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Tmux
map("", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
map("", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

-- Go
map("", "<leader>gsj", "<cmd> GoTagAdd json <CR>", { desc = "Add json struct tags" })
map("", "<leader>gsy", "<cmd> GoTagAdd yaml <CR>", { desc = "Add yaml struct tags" })
map("", "<leader>gse", "<cmd> GoTagAdd env <CR>", { desc = "Add env struct tags" })

-- Dap
map("", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Start Debugging" })
map("", "<leader>dt", "<cmd> DapTerminate <CR>", { desc = "Stop Debugging" })
map("", "<leader>dso", "<cmd> DapStepOver <CR>", { desc = "Step Over" })
map("", "<leader>dsi", "<cmd> DapStepInto <CR>", { desc = "Step Into" })
map("", "<leader>dst", "<cmd> DapStepOut <CR>", { desc = "Step Out" })
map("", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging Window" })