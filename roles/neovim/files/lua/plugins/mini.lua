return {
  "echasnovski/mini.nvim",
  event = "BufRead",
  version = false,
  config = function()
    require("mini.surround").setup()
    require("mini.operators").setup()
    require("mini.trailspace").setup({
      only_in_normal_buffers = true
    })

    vim.keymap.set("n", "<leader>cw", function()
      require("mini.trailspace").trim()
    end, { desc = "Trim trailing whitespace" })
    require("mini.splitjoin").setup({})
  end,
}
