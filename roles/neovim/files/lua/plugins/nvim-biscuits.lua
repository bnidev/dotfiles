return {
  "code-biscuits/nvim-biscuits",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-biscuits").setup({
      cursor_line_only = false,
      show_on_start = false,
    })
  end,
  keys = {
    {
      "<leader>bb",
      function()
        local biscuits = require("nvim-biscuits")
        biscuits.BufferAttach()
        biscuits.toggle_biscuits()

        if biscuits.should_render_biscuits then
          vim.notify("Biscuits enabled", vim.log.levels.INFO)
        else
          vim.notify("Biscuits disabled", vim.log.levels.INFO)
        end
      end,
      mode = "n",
      desc = "Toggle Biscuits",
    },
  },
}
