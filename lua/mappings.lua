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

---------------------------------- LSP ----------------------------------
map("n", "<leader>li", "<cmd> LspInfo <cr>", { desc = "LSP Info" })
map("n", "<leader>lr", "<cmd> LspRestart <cr>", { desc = "LSP Restart" })
map("n", "<leader>lf", function()
    vim.diagnostic.open_float { border = "rounded" }
end, { desc = "LSP Restart" })
map("n", "grr", function()
    require("telescope.builtin").lsp_references()
end, { desc = "Telescope: references" })
map("n", "gri", function()
    require("telescope.builtin").lsp_implementations()
end, { desc = "Telescope: implementations" })
map("n", "grt", function()
    require("telescope.builtin").lsp_type_definitions()
end, { desc = "Telescope: type definitions" })

---------------------------------- notify ----------------------------------
map("n", "<leader>nx", '<cmd> lua require("notify").dismiss() <CR>', { desc = "Close all notifications" })

---------------------------------- NEOTEST ----------------------------------
map('n', '<leader>nt', '<cmd> Neotest summary toggle <CR>', { desc = 'Neotest Toggle' })
map('n', '<leader>na', '<cmd> Neotest attach <CR>', { desc = 'Neotest attach logs' })
map('n', '<leader>nr', '<cmd> Neotest run <CR>', { desc = 'Neotest run closest' })
map(
    'n',
    '<leader>ndr',
    ' "<cmd> lua require("neotest").run.run({strategy = "dap"}) <CR>"',
    { desc = 'Neotest debug closest' }
)
map({ 'n', 'v' }, '<leader>no', '<cmd> Neotest output <CR>', { desc = 'Neotest output' })
