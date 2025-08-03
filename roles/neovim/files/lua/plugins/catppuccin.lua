return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- flavour = "macchiato"
        -- transparent_background = true,
        integrations = {
          flash = true, -- enable flash.nvim support
        },

        highlight_overrides = {
          all = function(colors)
            return {
              FlashBackdrop = { fg = "#545c7e" },
              FlashCurrent = { bg = "#ff966c", fg = "#1b1d2b" },
              FlashLabel = { bg = "#ff007c", fg = "#c8d3f5", bold = true },
              FlashMatch = { bg = "#3e68d7", fg = "#c8d3f5" },
              FlashCursor = { reverse = true },
            }
          end,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
