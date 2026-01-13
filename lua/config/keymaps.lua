-- 리더 키 설정
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
map("n","<C-h>","<C-w>h",{desc = "left"})
map("n","<C-j>","<C-w>j",{desc = "under"})
map("n","<C-k>","<C-w>k",{desc = "up"})
map("n","<C-l>","<C-w>l",{desc = "right"})

map("n","<leader>tn","<cmd>BufferLineCycleNext<cr>")
map("n","<leader>tp","<cmd>BufferLineCyclePrev<cr>")
map("n","<leader>tc","<cmd>bdelete<cr>")
map("n","<leader>tl","<cmd>BufferLinePick<cr>")

