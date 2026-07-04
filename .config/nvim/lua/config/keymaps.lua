-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
map("", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })
map("", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })

-- Resize
map("", "<A-h>", "<cmd> vertical resize -5<CR>", { desc = "Resize Left" })
map("", "<A-l>", "<cmd> vertical resize +5<CR>", { desc = "Resize Right" })
map("", "<A-j>", "<cmd> horizontal resize -5<CR>", { desc = "Resize Down" })
map("", "<A-k>", "<cmd> horizontal resize +5<CR>", { desc = "Resize Up" })
