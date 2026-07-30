return {
  { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { ignored = true },
          grep = { ignored = true },
        },
      },
      explorer = {
        ignored = true,
        git_untracked = true,
      },
    },
  },
}
