-- leader
vim.g.mapleader = " "

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bl", ":BufferLinePick<CR>", { desc = "Pick buffer" })

-- move lines
vim.keymap.set({ "n", "v" }, "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "n", "v" }, "<A-k>", ":m '<-2<CR>gv=gv")

-- rename
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Obsidian
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>", { desc = "Format Obsidian Headline" })

-- Markdown Preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" })

-- Todo Comments
vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>", { desc = "Find Todo Comments" })

-- Switch
vim.keymap.set("n", "<leader>s", ":Switch<CR>", { desc = "Switch" })

-- GitHub Copilot
vim.keymap.set({ "n", "v" }, "<leader>gc", ":CopilotChat<CR>", { desc = "GitHub Copilot" })

-- Luasnip
vim.keymap.set("i", "<A-j>", function() require('luasnip').jump(1) end, { desc = "Jump to next snippet node" })
vim.keymap.set("i", "<A-k>", function() require('luasnip').jump(-1) end, { desc = "Jump to previous snippet node" })
