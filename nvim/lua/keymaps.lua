-- leader 
vim.g.mapleader = " "

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<CR>")
vim.keymap.set("n", "<leader>p", ":bp<CR>")
vim.keymap.set("n", "<leader>c", ":bd<CR>")

-- move lines
vim.keymap.set({"n", "v"}, "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set({"n", "v"}, "<A-k>", ":m '<-2<CR>gv=gv")
