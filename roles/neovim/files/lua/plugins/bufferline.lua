return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        separator_style = "thick",
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return icon .. count
        end,
      },
    })
  end,
}
