local keymap = vim.keymap

vim.g.mapleader = " "

-- execute
keymap.set("n", "<leader><leader>x", function()
  vim.cmd("source %")
  vim.notify("File sourced", vim.log.levels.INFO)
end)
keymap.set("n", "<leader>x", ":.lua<CR>")
keymap.set("v", "<leader>x", ":lua<CR>")

-- vertical movement with placing cursor in the middle of
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- center cursor when going though search
keymap.set("n", "n", "nzz", { noremap = true })
keymap.set("n", "N", "Nzz", { noremap = true })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- paste from clipboard without copying into register
keymap.set("x", "p", '"_dP')

-- delete without copying into register
keymap.set("n", "<leader>dd", '"_dd')
keymap.set("v", "<leader>d", '"_d')

-- changing without yanking
keymap.set("n", "cc", '"_cc')
keymap.set("n", "c", '"_c')
keymap.set("v", "c", '"_c')
keymap.set("v", "C", '"_c')

-- move selected line(s) down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- move selected line(s) up
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- oil.nvim
keymap.set("n", "<leader>e", "<cmd>Oil<CR>")

keymap.set("n", "]d",
           function()
             vim.diagnostic.jump({
               count = 1,
               float = {
                 border =
                 "rounded"
               }
             })
           end)
keymap.set("n", "[d",
           function()
             vim.diagnostic.jump({
               count = -1,
               float = {
                 border =
                 "rounded"
               }
             })
           end)
