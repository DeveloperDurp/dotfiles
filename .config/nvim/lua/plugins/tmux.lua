return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    local map = vim.keymap.set
    map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Window Left" })
    map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Window Down" })
    map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Window Up" })
    map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Window Right" })
    map("n", "<C-\\", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Previous Window" })
  end,
}
