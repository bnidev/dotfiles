vim.api.nvim_create_user_command("ReloadSnippets", function()
  local snippet_path = vim.fn.stdpath("config") .. "/lua/custom/luasnip"
  require("luasnip.loaders.from_lua").lazy_load({ paths = snippet_path })
end, {})
