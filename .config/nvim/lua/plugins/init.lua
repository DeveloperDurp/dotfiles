return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "rust-analyzer",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "powershell-editor-services",
        "bash-language-server",
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server"
      },
    },
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "terraform",
        "c_sharp",
        "bash",
  		},
  	},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
     require("nvchad.configs.lspconfig").defaults()
     require "configs.lspconfig"
    end,
  },
}
