local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- Tmux
map(
  "",
  "<C-h>",
  "<cmd> TmuxNavigateLeft<CR>",
  { desc = "window left" }
)
map(
  "",
  "<C-l>",
  "<cmd> TmuxNavigateRight<CR>",
  { desc = "window right" }
)
map(
  "",
  "<C-j>",
  "<cmd> TmuxNavigateDown<CR>",
  { desc = "window down" }
)
map("", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

-- Resize
map(
  "",
  "<A-h>",
  "<cmd> vertical resize -5<CR>",
  { desc = "Resize Left" }
)
map(
  "",
  "<A-l>",
  "<cmd> vertical resize +5<CR>",
  { desc = "Resize Right" }
)
map(
  "",
  "<A-j>",
  "<cmd> horizontal resize -5<CR>",
  { desc = "Resize Down" }
)
map(
  "",
  "<A-k>",
  "<cmd> horizontal resize +5<CR>",
  { desc = "Resize Up" }
)

-- Go
map(
  "",
  "<leader>gsj",
  "<cmd> GoTagAdd json <CR>",
  { desc = "Add json struct tags" }
)
map(
  "",
  "<leader>gsy",
  "<cmd> GoTagAdd yaml <CR>",
  { desc = "Add yaml struct tags" }
)
map(
  "",
  "<leader>gse",
  "<cmd> GoTagAdd env <CR>",
  { desc = "Add env struct tags" }
)

-- Dap
map(
  "",
  "<leader>db",
  "<cmd> DapToggleBreakpoint <CR>",
  { desc = "Add breakpoint at line" }
)
map(
  "",
  "<leader>dc",
  "<cmd> DapContinue <CR>",
  { desc = "Start Debugging" }
)
map(
  "",
  "<leader>dt",
  "<cmd> DapTerminate <CR>",
  { desc = "Stop Debugging" }
)
map(
  "",
  "<leader>dso",
  "<cmd> DapStepOver <CR>",
  { desc = "Step Over" }
)
map(
  "",
  "<leader>dsi",
  "<cmd> DapStepInto <CR>",
  { desc = "Step Into" }
)
map("", "<leader>dst", "<cmd> DapStepOut <CR>", { desc = "Step Out" })
map("", "<leader>dus", function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging Window" })

-- Movement
map("n", "<C-d>", "<c-d>zz", { noremap = true })
map("n", "<C-u>", "<c-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- Powershell
map("n", "<leader>E", function()
  require("powershell").eval()
end, { noremap = true })
map("n", "<leader>P", function()
  require("powershell").toggle_term()
end, { noremap = true })

-- CodeCopmanion
map(
  "",
  "<leader>Ca",
  "<cmd>CodeCompanionActions <CR>",
  { desc = "CodeCompanion Actions" }
)
map(
  "",
  "<leader>Cc",
  "<cmd>CodeCompanionChat <CR>",
  { desc = "CodeCompanion Chat" }
)

-- Custom
map(
  "",
  "<leader>rw",
  '"hy:%s/<C-r>h//g<left><left>',
  { noremap = true, silent = true, desc = "Replace Word" }
)

map("", "<leader>rt", ":VtrSendLinesToRunner<CR>", {
  noremap = true,
  silent = true,
  desc = "Send selected text to tmux pane",
})

map(
  "",
  "<leader>rp",
  ":VtrAttachToPane<CR>",
  { noremap = true, silent = true, desc = "Attach to tmux pane" }
)
