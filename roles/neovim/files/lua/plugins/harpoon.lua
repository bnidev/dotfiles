return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        save_on_ui_close = true,
      },
    })

    local extensions = require("harpoon.extensions")
    harpoon:extend(extensions.builtins.highlight_current_file())
    harpoon:extend(extensions.builtins.navigate_with_number())

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Add file to Harpoon" })
    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle Harpoon list" })
    vim.keymap.set("n", "h1", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "h2", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "h3", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "h4", function()
      harpoon:list():select(4)
    end)
  end,
}
