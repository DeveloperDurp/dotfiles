return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt", "golines" },
      },
      formatters = {
        golines = {
          command = "golines",
          args = { "--max-length", "100", "-" },
          stdin = true,
        },
      },
    },
    init = function()
      -- Go-only format-on-save.
      -- LazyVim wires BufWritePre -> LazyVim.format, which checks
      -- vim.b.autoformat (buffer) -> vim.g.autoformat (global) -> true.
      -- Setting global false + per-buffer true on FileType go = go only.
      vim.g.autoformat = false
      local id = vim.api.nvim_create_augroup("GoFormatOnSave", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = id,
        pattern = "go",
        callback = function() vim.b.autoformat = true end,
      })
    end,
  },
}
