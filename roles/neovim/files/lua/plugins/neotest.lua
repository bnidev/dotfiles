return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-vitest")
      },
    })

    vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>ti", neotest.output.open, { desc = "Show output information" })
    vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle summary" })
  end
}
