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
      display = {
        chat = {
          layout = "horizontal",
        },
      },
      interactions = {
        chat = {
          adapter = {
            name = "ollama",
            model = "gemma4:e4b",
          },
        },
        inline = {
          adapter = {
            name = "ollama",
            model = "gemma4:e4b",
          },
        },
        cmd = {
          adapter = {
            name = "ollama",
            model = "gemma4:e4b",
          },
        },
      },
      adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend(
              "ollama",
              {
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
              }
            )
          end,
          anthropic = function()
            return require("codecompanion.adapters").extend(
              "anthropic",
              {
                --schema = {
                --  model = {
                --    default = "claude-3-5-haiku",
                --  },
                --},
                env = {
                  api_key = "ANTHROPIC_TOKEN",
                },
              }
            )
          end,
          gemini = function()
            return require("codecompanion.adapters").extend(
              "gemini",
              {
                --schema = {
                --  model = {
                --    default = "claude-3-5-haiku",
                --  },
                --},
                env = {
                  api_key = "GEMINI_TOKEN",
                },
              }
            )
          end,
          openai = function()
            return require("codecompanion.adapters").extend(
              "openai",
              {
                --schema = {
                --  model = {
                --    default = "claude-3-5-haiku",
                --  },
                --},
                env = {
                  api_key = "OPENAI_TOKEN",
                },
              }
            )
          end,
        },
      },
    },
  },
}
