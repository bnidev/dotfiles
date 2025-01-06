-- leader
vim.g.mapleader = " "

-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<CR>")
vim.keymap.set("n", "<leader>p", ":bp<CR>")
vim.keymap.set("n", "<leader>c", ":bd<CR>")

-- move lines
vim.keymap.set({ "n", "v" }, "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "n", "v" }, "<A-k>", ":m '<-2<CR>gv=gv")

-- rename
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- Obsidian
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate<CR>")
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")

-- Markdown Preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>")

-- Todo Comments
vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>")
