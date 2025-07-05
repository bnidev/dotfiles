return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup({
      file_types = { "markdown", "copilot-chat" },
      completions = { lsp = { enabled = true } },
    })
  end,
}
