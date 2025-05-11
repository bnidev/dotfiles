return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "material",
      },
      sections = {
        lualine_a = {
          {
            "diff",
            colored = true,
            diff_color = {
              added = "LuaLineDiffAdd",
              modified = "LuaLineDiffChange",
              removed = "LuaLineDiffDelete",
            },
            symbols = { added = "+", modified = "~", removed = "-" },
            source = nil, -- A function that works as a data source for diff.
            -- It must return a table as such:
            --   { added = add_count, modified = modified_count, removed = removed_count }
            -- or nil on failure. count <= 0 won't be displayed.
          },
        },
      },
    })
  end,
}
