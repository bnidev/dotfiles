return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					mappings = {
						i = {
							["<c-d>"] = require("telescope.actions").delete_buffer,
						},
						n = {
							["<c-d>"] = require("telescope.actions").delete_buffer,
							["dd"] = require("telescope.actions").delete_buffer,
						},
					},
				},
				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", function() builtin.find_files({ hidden = true }) end, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})

			vim.keymap.set("n", "<space>fp", function()
				require("telescope.builtin").find_files({
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
				})
			end)

      vim.keymap.set('n', '<leader>gh', function()
        local file_path = vim.api.nvim_buf_get_name(0)
        if file_path == '' then
          vim.notify("No file open", vim.log.levels.WARN)
          return
        end

        local handle = io.popen('git -C "' .. vim.fn.fnamemodify(file_path, ":h") .. '" rev-parse --show-toplevel 2>/dev/null')
        local git_root = handle and handle:read("*l") or nil
        if handle then handle:close() end

        if not git_root or git_root == '' then
          vim.notify("Not inside a Git repository", vim.log.levels.WARN)
          return
        end

        builtin.git_bcommits({
          cwd = git_root,
        })
      end, { desc = "Telescope Git file history (git_bcommits)" })

			require("custom.telescope.multigrep").setup()
		end,
	},
}
