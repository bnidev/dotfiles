return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        "<leader>f",
        group = "Find",
      },
      {
        "<leader>o",
        group = "Obsidian",
      },
      {
        "<leader>m",
        group = "Markdown",
      },
      {
        "<leader>x",
        group = "Trouble",
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
