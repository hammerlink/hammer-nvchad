require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "fd", "<ESC>")
map("n", "<leader>tx", "<cmd> tabclose <CR>", { desc = "Tab close" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- neogit
map("n", "<leader>gg", "<cmd> Neogit <cr>", { desc = "Open NeoGit" })
-- diffview
map("n", "<leader>gd", "<cmd> DiffviewOpen <cr>", { desc = "Git Changes Diffview" })
map("n", "<leader>gh", "<cmd> DiffviewFileHistory <cr>", { desc = "Git FileHistory Diffview all" })
map({ "n", "v" }, "<leader>gs", ":DiffviewFileHistory %<cr>", { desc = "Gile FileHistory current buffer / selection" })
map("n", "<leader>gr", "<cmd> DiffviewRefresh <cr>", { desc = "Diffview refresh" })
