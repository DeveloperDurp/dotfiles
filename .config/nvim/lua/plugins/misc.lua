return {
  --{
  --  "folke/trouble.nvim",
  --  opts = { use_diagnostic_signs = true },
  --},
  --{
  --  "neovim/nvim-lspconfig",
  --  ---@class PluginLspOpts
  --  opts = {
  --    servers = {
  --      --pyright = {
  --      --  filetypes = { "python" },
  --      --},
  --      gopls = {
  --        cmd = { "gopls" },
  --        filetypes = { "go", "gomod", "gowork", "gotmpl" },
  --        --root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  --        settings = {
  --          gopls = {
  --            completeUnimported = true,
  --            usePlaceholders = true,
  --            analyses = {
  --              unusedparams = true,
  --            },
  --          },
  --        },
  --      },
  --      --tsserver = {},
  --      powershell_es = {
  --        bundle_path = vim.fn.stdpath("data")
  --          .. "/mason/packages/powershell-editor-services",
  --      },
  --    },
  --  },
  --},
  --{
  --  "lewis6991/gitsigns.nvim",
  --  config = function()
  --    require("gitsigns").setup()
  --  end,
  --},
  --{
  --  "olexsmir/gopher.nvim",
  --  ft = "go",
  --  config = function(_, opts)
  --    require("gopher").setup(opts)
  --  end,
  --  build = function()
  --    vim.cmd([[silent! GoInstallDeps]])
  --  end,
  --},
  --{
  --  "MeanderingProgrammer/render-markdown.nvim",
  --  dependencies = {
  --    "nvim-treesitter/nvim-treesitter",
  --    "echasnovski/mini.nvim",
  --  }, -- if you use the mini.nvim suite
  --  ---@module 'render-markdown'
  --  ---@type render.md.UserConfig
  --  opts = {},
  --},
  {
    "mistweaverco/kulala.nvim",
    opts = {
      global_keymaps = true,
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95,
        width = 180,
        height = 1,
      },
    },
  },
}
