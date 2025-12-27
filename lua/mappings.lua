require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "fd", "<ESC>")
map("n", "<leader>tx", "<cmd> tabclose <CR>", { desc = "Tab close" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- path show
map("n", "<leader>ps", function()
    local filepath = vim.fn.expand "%:p"
    if filepath == "" then
        filepath = "[No Name]"
    end

    -- Create a floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Current File Path:", "", filepath })

    local opts = {
        relative = "cursor",
        width = math.min(#filepath + 4, vim.o.columns - 4),
        height = 3,
        row = 1,
        col = 0,
        style = "minimal",
        border = "rounded",
        focusable = true,
    }

    local win_id = vim.api.nvim_open_win(buf, true, opts) -- true = focus immediately

    -- Set up 'q' to close the window
    vim.keymap.set("n", "q", function()
        if vim.api.nvim_win_is_valid(win_id) then
            vim.api.nvim_win_close(win_id, true)
        end
    end, { buffer = buf, nowait = true })
end, { desc = "Show current file path" })

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
map("n", "<leader>fc", "<cmd> Telescope commands <cr>", { desc = "Browse commands" })
map("n", "<leader>fk", "<cmd> Telescope keymaps <cr>", { desc = "Browse keymaps" })
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
map("n", "<leader>nt", "<cmd> Neotest summary toggle <CR>", { desc = "Neotest Toggle" })
map("n", "<leader>na", "<cmd> Neotest attach <CR>", { desc = "Neotest attach logs" })
map("n", "<leader>nr", "<cmd> Neotest run <CR>", { desc = "Neotest run closest" })
map(
    "n",
    "<leader>ndr",
    ' "<cmd> lua require("neotest").run.run({strategy = "dap"}) <CR>"',
    { desc = "Neotest debug closest" }
)
map({ "n", "v" }, "<leader>no", "<cmd> Neotest output <CR>", { desc = "Neotest output" })

---------------------------------- Tabbufline ----------------------------------
map("n", "<A-l>", function()
    require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<A-h>", function()
    require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

---------------------------------- Terminal ----------------------------------
map({ "n", "t" }, "<A-s>", function()
    require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-v>", function()
    require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.45 }
end, { desc = "terminal toggleable vertical term" })

---------------------------------- GitSigns ----------------------------------
map("n", "<leader>rh", function()
    require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
map("n", "<leader>ph", function()
    require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
map("n", "]c", function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        require("gitsigns").next_hunk()
    end)
    return "<Ignore>"
end, { desc = "Jump to next hunk", expr = true })

map("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        require("gitsigns").prev_hunk()
    end)
    return "<Ignore>"
end, { desc = "Jump to previous hunk", expr = true })

vim.keymap.set("n", "<leader>gb", function()
    local gs = require "gitsigns"
    gs.blame_line { full = true }
end, { desc = "Show full Git blame info in a floating window" })

---------------------------------- Aerial ----------------------------------
map("n", "<leader>at", "<cmd> AerialToggle <CR>", { desc = "Aerial Toggle" })

---------------------------------- DAP -------------------------------------
-- DAP mappings
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue" })
map("n", "<leader>ds", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
map("n", "<leader>dr", "<cmd>DapRestart<CR>", { desc = "Restart" })
map("n", "<leader>dt", "<cmd>DapTerminate<CR>", { desc = "Terminate" })
-- Conditional breakpoint
map("n", "<leader>dB", function()
    local condition = vim.fn.input "Breakpoint condition: "
    if condition ~= "" then
        require("dap").set_breakpoint(condition)
    end
end, { desc = "Set Conditional Breakpoint" })

-- Log point (breakpoint with message)
map("n", "<leader>dl", function()
    local message = vim.fn.input "Log point message: "
    if message ~= "" then
        require("dap").set_breakpoint(nil, nil, message)
    end
end, { desc = "Set Log Point" })

-- Hit count breakpoint
map("n", "<leader>dh", function()
    local hit_count = vim.fn.input "Hit count: "
    if hit_count ~= "" and tonumber(hit_count) then
        require("dap").set_breakpoint(nil, tonumber(hit_count))
    end
end, { desc = "Set Hit Count Breakpoint" })

-- DAP UI mappings
map("n", "<leader>du", function()
    require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
map("n", "<leader>de", function()
    require("dapui").eval()
end, { desc = "Evaluate Expression" })
