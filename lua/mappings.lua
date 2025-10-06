require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "fd", "<ESC>")
map("n", "<leader>tx", "<cmd> tabclose <CR>", { desc = "Tab close" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

---------------------------------- neogit ----------------------------------
map("n", "<leader>gg", "<cmd> Neogit <cr>", { desc = "Open NeoGit" })

---------------------------------- diffview ----------------------------------
map("n", "<leader>gd", "<cmd> DiffviewOpen <cr>", { desc = "Git Changes Diffview" })
map("n", "<leader>gh", "<cmd> DiffviewFileHistory <cr>", { desc = "Git FileHistory Diffview all" })
map({ "n", "v" }, "<leader>gs", ":DiffviewFileHistory %<cr>", { desc = "Gile FileHistory current buffer / selection" })
map("n", "<leader>gr", "<cmd> DiffviewRefresh <cr>", { desc = "Diffview refresh" })

---------------------------------- telescope ----------------------------------
map("n", "<leader>fr", "<cmd> Telescope resume <cr>", { desc = "Resume last find" })
map("n", "<leader>fj", "<cmd> Telescope jump_list <cr>", { desc = "Find recent file visits" })
map("n", "<leader>fn", "<cmd> Telescope notify <cr>", { desc = "Browse notifications" })
map("n", "<leader>fx", function()
    require("telescope.builtin").diagnostics { bufnr = 0 }
end, { desc = "Find diagnostics" })
map("n", "<leader>fw", function()
    local search_dir = vim.fn.getcwd()
    -- check if the nvim-tree is focused
    if vim.bo.filetype == "NvimTree" then
        local selected_node = require("nvim-tree.api").tree.get_node_under_cursor()
        if selected_node then
            if selected_node.type == "directory" then
                search_dir = selected_node.absolute_path
                print("telescope cwd " .. search_dir)
            end
        end
    end
    require("telescope.builtin").live_grep { cwd = search_dir }
end, { desc = "Live grep" })

map("n", "<leader>ff", function()
    local search_dir = vim.fn.getcwd()
    -- check if the nvim-tree is focused
    if vim.bo.filetype == "NvimTree" then
        local selected_node = require("nvim-tree.api").tree.get_node_under_cursor()
        if selected_node then
            if selected_node.type == "directory" then
                search_dir = selected_node.absolute_path
                print("telescope cwd " .. search_dir)
            end
        end
    end
    require("telescope.builtin").find_files { cwd = search_dir }
end, { desc = "Find files" })
