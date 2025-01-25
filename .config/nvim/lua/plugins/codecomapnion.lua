local OLLAMA_TOKEN = os.getenv("OLLAMA_TOKEN")
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    opts = {
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama",
            schema = {
              model = {
                default = "llama3.1:latest",
              },
            },
            env = {
              url = "https://ollama.durp.info",
            },
            headers = {
              ["Content-Type"] = "application/json",
              ["Authorization"] = OLLAMA_TOKEN,
            },
            parameters = {
              sync = true,
            },
          })
        end,
      },
    },
  },
}
