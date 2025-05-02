local OLLAMA_TOKEN = os.getenv("OLLAMA_TOKEN")
local OPENAI_TOKEN = os.getenv("OPENAI_TOKEN")
local GEMINI_TOKEN = os.getenv("GEMINI_TOKEN")
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
        opts = {
          show_defaults = false,
        },
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            name = "gemini",
            schema = {
              model = {
                default = "gemini-2.0-flash",
              },
            },
            env = {
              api_key = GEMINI_TOKEN,
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "openai",
            schema = {
              model = {
                default = "gpt-4o-mini",
              },
            },
            env = {
              api_key = OPENAI_TOKEN,
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama",
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
