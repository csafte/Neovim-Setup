-- 리더 키 설정
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map 변수로 키맵 단축
local map = vim.keymap.set

-- Neotree 토글 키맵
map("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
map("n","<C-h>","<C-w>h",{desc = "left"})
map("n","<C-j>","<C-w>j",{desc = "under"})
map("n","<C-k>","<C-w>k",{desc = "up"})
map("n","<C-l>","<C-w>l",{desc = "right"})

--Neovim TabPages 설정
map("n","<leader>tn", ":tabnew<CR>")
map("n","<leader>th", ":tabprev<CR>")
map("n","<leader>tl", ":tabnext<CR>")
map("n","<leader>tc", ":tabclose<CR>")
