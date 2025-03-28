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
        chat = { adapter = "openai" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        opts = {
          show_defaults = false,
        },
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "gpt-4o-mini",
              },
            },
            url = "https://litellm.durp.info",
            env = {
              api_key = "sk-8lkQVLNLOMYeblJhaqcaCw",
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama",
            schema = {
              model = {
                default = "llama3.1:latest",
              },
            },
            env = {
              url = "https://litellm.durp.info",
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
