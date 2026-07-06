local M = {}

function M.load()
  local ls = require("luasnip")
  local snippet = ls.snippet
  local insert = ls.insert_node
  local function_node = ls.function_node

  ls.add_snippets("all", {
    snippet("todo", {
      function_node(function()
        return "// TODO (" .. (vim.env.USER or "") .. ") : "
      end),
      insert(1),
    }),
  })
end

return M