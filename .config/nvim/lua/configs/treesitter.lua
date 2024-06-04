local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.powershell_es = {
  install_info = {
    url = "/home/user/.local/share/tree-sitter-PowerShell",
    files = { "src/parser.c" },
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "ps1",
}
return parser_config
