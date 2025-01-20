return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.surround").setup()
    require("mini.operators").setup()
  end,
}
