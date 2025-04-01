local OLLAMA_TOKEN = os.getenv("OLLAMA_TOKEN")
local LITELLM_TOKEN = os.getenv("LITELLM_TOKEN")
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
              api_key = LITELLM_TOKEN,
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "mistral",
            schema = {
              model = {
                default = "mistral:latest",
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
