return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  -- lazy load treesitter
  event = { "BufReadPre", "BufNewFile"},
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
	config = function()
		local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
		treesitter.setup({
      -- install new parsers automatically
      auto_install = true,
      -- enable syntax highlighting
      highlight = { enable = true },
      -- enable indentation
      indent = { enable = true },
      -- ensure the following language parsers are installed
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"markdown",
				"markdown_inline",
				"yaml",
				"toml",
				"json",
				"html",
				"css",
				"vue",
				"json",
				"php",
				"bash",
				"dockerfile",
				"gitignore",
				"fish",
				"git_config",
				"ssh_config",
				"vim",
			},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>"
        }
      }
		})
	end,
}
