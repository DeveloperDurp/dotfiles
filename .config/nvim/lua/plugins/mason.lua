return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    opts = {
      ensure_installed = {
        --"gopls",
        --"rust-analyzer",
        --"pyright",
        --"mypy",
        --"ruff",
        --"black",
        --"debugpy",
        "powershell-editor-services",
        "bash-language-server",
        --"eslint-lsp",
        --"js-debug-adapter",
        --"prettier",
        --"typescript-language-server",
        --"stylua",
        --"shellcheck",
        --"shfmt",
        --"flake8",
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
