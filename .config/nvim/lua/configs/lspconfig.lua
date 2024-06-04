local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
--local servers = { "html", "cssls" }

-- lsps with default config
--for _, lsp in ipairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = on_attach,
--    on_init = on_init,
--    capabilities = capabilities,
--  }
--end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

lspconfig.powershell_es.setup({
  bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
})

lspconfig.bashls.setup({})

omnisharp_bin = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp"

lspconfig.omnisharp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "cs"},
  cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
})
