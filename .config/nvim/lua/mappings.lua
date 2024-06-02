require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
map("", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

