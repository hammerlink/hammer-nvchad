require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- escape modus
map("i", "jk", "<ESC>", { desc = "custom escape" })
map("v", "jk", "<ESC>", { desc = "custom escape" })

-- neogit
map("n", "<leader>gg", "<cmd> Neogit <cr>", { desc = "Open NeoGit" })

-- Disable mappings
local nomap = vim.keymap.del
