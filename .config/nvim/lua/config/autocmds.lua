-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-reload files when they change on disk (pairs with vim.opt.autoread)
vim.api.nvim_create_augroup("AutoReloadOnChange", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = "AutoReloadOnChange",
  callback = function() vim.cmd("checktime") end,
})

vim.api.nvim_create_augroup("DisableMarkdownDiagnostics", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "DisableMarkdownDiagnostics",
  pattern = "markdown",
  callback = function() vim.diagnostic.disable(0) end,
})
