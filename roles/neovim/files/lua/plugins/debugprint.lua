local js_like = {
  left = 'console.info("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}

return {
  "andrewferrier/debugprint.nvim",
  opts = {
    display_counter = false,
    highlight_lines = false,
    print_tag = '',
    keymaps = {
      normal = {
        variable_below = "<leader>l",
        variable_above = "<leader>la",
      },
    },
    filetypes = {
      ["javascript"] = js_like,
      ["javascriptreact"] = js_like,
      ["typescript"] = js_like,
      ["typescriptreact"] = js_like,
    },
  },
  lazy = false, -- Required to make line highlighting work before debugprint is first used
  version = "*", -- Remove if you DON'T want to use the stable version
}
