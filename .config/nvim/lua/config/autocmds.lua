local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("go_fmt", { clear = true })

autocmd("FileType", {
  group = "go_fmt",
  pattern = "go",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<leader>F",
      ":lua FormatGoCurrentLine()<CR>",
      { noremap = true, silent = true }
    )
  end,
})

function FormatGoCurrentLine()
  local line = vim.api.nvim_get_current_line()
  local formatted_line = line:gsub("%(", "(\n"):gsub(",%s*", ",\n"):gsub("%)", ",\n)")
  formatted_line = formatted_line:gsub(",\n%)", "\n)")
  local lines = vim.split(formatted_line, "\n")
  -- Ensure the last parameter has a comma
  if #lines > 2 and not lines[#lines - 1]:match(",$") then
    lines[#lines - 1] = lines[#lines - 1] .. ","
  end
  vim.api.nvim_buf_set_lines(0, vim.fn.line(".") - 1, vim.fn.line("."), false, lines)
end
