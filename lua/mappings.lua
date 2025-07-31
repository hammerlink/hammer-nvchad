require 'nvchad.mappings'
local cargo_check = require 'rust.cargo-check'

-- add yours here

local map = vim.keymap.set

map({ 'x' }, 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = 'Dont copy replaced text', silent = true })
-- escape modus
map({ 't', 'v', 'n', 'i' }, '<A-c>', '<ESC>', { desc = 'custom escape' })
map('i', 'fd', '<ESC>', { desc = 'custom escape' })
map('n', '<leader>tx', '<cmd> tabclose <CR>', { desc = 'Tab close' })

-- nvim-tree
map('n', '<leader>ti', function()
    local nvim_tree = require 'nvim-tree.api'
    local count = vim.v.count ~= 0 and vim.v.count or 1
    local relative = count > 1 and count or 5
    nvim_tree.tree.resize { relative = relative }
end, { desc = 'Tree increase width' })
map('n', '<leader>td', function()
    local nvim_tree = require 'nvim-tree.api'
    local count = vim.v.count ~= 0 and vim.v.count or 1
    local relative = count > 1 and count or 5
    nvim_tree.tree.resize { relative = -relative }
end, { desc = 'Tree decrease width' })
map('n', '<leader>tr', function()
    local nvim_tree = require 'nvim-tree.api'
    nvim_tree.tree.resize { width = 30}
end, { desc = 'Tree width default' })

-- neogit
map('n', '<leader>gg', '<cmd> Neogit <cr>', { desc = 'Open NeoGit' })
-- diffview
map('n', '<leader>gd', '<cmd> DiffviewOpen <cr>', { desc = 'Git Changes Diffview' })
map('n', '<leader>gh', '<cmd> DiffviewFileHistory <cr>', { desc = 'Git FileHistory Diffview all' })
map({ 'n', 'v' }, '<leader>gs', ':DiffviewFileHistory %<cr>', { desc = 'Gile FileHistory current buffer / selection' })
map('n', '<leader>gr', '<cmd> DiffviewRefresh <cr>', { desc = 'Diffview refresh' })

-- telescope
map('n', '<leader>fr', '<cmd> Telescope resume <cr>', { desc = 'Resume last find' })
map('n', '<leader>fj', '<cmd> Telescope jump_list <cr>', { desc = 'Find recent file visits' })
map('n', '<leader>fn', '<cmd> Telescope notify <cr>', { desc = 'Browse notifications' })
map('n', '<leader>fx', function()
    require('telescope.builtin').diagnostics { bufnr = 0 }
end, { desc = 'Find diagnostics' })
map('n', '<leader>fw', function()
    local search_dir = vim.fn.getcwd()
    -- check if the nvim-tree is focused
    if vim.bo.filetype == 'NvimTree' then
        local selected_node = require('nvim-tree.api').tree.get_node_under_cursor()
        if selected_node then
            if selected_node.type == 'directory' then
                search_dir = selected_node.absolute_path
                print('telescope cwd ' .. search_dir)
            end
        end
    end
    require('telescope.builtin').live_grep { cwd = search_dir }
end, { desc = 'Live grep' })

map('n', '<leader>ff', function()
    local search_dir = vim.fn.getcwd()
    -- check if the nvim-tree is focused
    if vim.bo.filetype == 'NvimTree' then
        local selected_node = require('nvim-tree.api').tree.get_node_under_cursor()
        if selected_node then
            if selected_node.type == 'directory' then
                search_dir = selected_node.absolute_path
                print('telescope cwd ' .. search_dir)
            end
        end
    end
    require('telescope.builtin').find_files { cwd = search_dir }
end, { desc = 'Find files' })

-- LSP
map('n', '<leader>li', '<cmd> LspInfo <cr>', { desc = 'LSP Info' })
map('n', '<leader>lr', '<cmd> LspRestart <cr>', { desc = 'LSP Restart' })
map('n', '<leader>lf', function()
    vim.diagnostic.open_float { border = 'rounded' }
end, { desc = 'LSP Restart' })
map('n', 'gd', function()
    require('telescope.builtin').lsp_definitions()
end, { desc = 'LSP Definition' })
map('n', 'gr', '<cmd> Telescope lsp_references <cr>', { desc = 'LSP references' })
map('n', '<leader>lR', function()
    cargo_check.CargoQuickfix()
end, { desc = 'Cargo check' })
map({ 'n', 'v' }, '<leader>ca', function()
    vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { desc = 'code action' })

-- Avante
map('v', '<leader>av', '<cmd> AvanteToggle <CR>', { desc = 'Avante Toggle' })
map({ 'n', 'v' }, '<leader>ax', function()
    vim.cmd 'AvanteClear'
    -- Wait for 100ms before asking
    vim.defer_fn(function()
        vim.cmd 'AvanteAsk'
    end, 100)
end, { desc = 'Avante Clear and Ask' })

-- Tabbufline
map('n', '<A-l>', function()
    require('nvchad.tabufline').next()
end, { desc = 'buffer goto next' })

map('n', '<A-h>', function()
    require('nvchad.tabufline').prev()
end, { desc = 'buffer goto prev' })

-- Terminal
map({ 'n', 't' }, '<A-s>', function()
    require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
end, { desc = 'terminal toggleable horizontal term' })

-- Overseer
map('n', '<leader>ot', '<cmd> OverseerToggle <CR>', { desc = 'Overseer Toggle' })
map('n', '<leader>or', '<cmd> OverseerRun <CR>', { desc = 'Overseer Run' })
map('n', '<leader>oo', '<cmd> OverseerQuickAction <CR>', { desc = 'Overseer quick action' })
map('n', '<leader>nx', '<cmd> lua require("notify").dismiss() <CR>', { desc = 'Close all notifications' })

-- Aerial
map('n', '<leader>aet', '<cmd> AerialToggle <CR>', { desc = 'Aerial Toggle' })

-- Gitsigns
map('n', '<leader>rh', function()
    require('gitsigns').reset_hunk()
end, { desc = 'Reset hunk' })
map('n', '<leader>ph', function()
    require('gitsigns').preview_hunk()
end, { desc = 'Preview hunk' })
map('n', ']c', function()
    if vim.wo.diff then
        return ']c'
    end
    vim.schedule(function()
        require('gitsigns').next_hunk()
    end)
    return '<Ignore>'
end, { desc = 'Jump to next hunk', expr = true })

map('n', '[c', function()
    if vim.wo.diff then
        return '[c'
    end
    vim.schedule(function()
        require('gitsigns').prev_hunk()
    end)
    return '<Ignore>'
end, { desc = 'Jump to previous hunk', expr = true })

-- UndoTree
map('n', '<leader>ut', '<cmd> UndotreeToggle <CR>', { desc = 'Undotree Toggle' })
map('n', '<leader>ur', '<cmd> UndotreeFocus <CR>', { desc = 'Undotree Focus' })

-- NEOTEST
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

-- Print file path
map('n', '<leader>fp', function()
    local path = vim.fn.expand '%:p'
    print(path)
end, { desc = 'Print file absolute path' })

-- DAP
-- DAP F KEYS
map({ 'n', 'v' }, '<F5>', function()
    require('dap').continue()
end, { desc = 'Debug: Continue' })
map({ 'n', 'v' }, '<F10>', function()
    require('dap').step_over()
end, { desc = 'Debug: Step Over' })
map({ 'n', 'v' }, '<F11>', function()
    require('dap').step_into()
end, { desc = 'Debug: Step Into' })
map({ 'n', 'v' }, '<F12>', function()
    require('dap').step_out()
end, { desc = 'Debug: Step Out' })
-- DAP CONTROL
map('n', '<leader>db', function()
    require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<leader>dB', function()
    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Conditional Breakpoint' })
map('n', '<leader>dl', function()
    require('dap').run_last()
end, { desc = 'Debug: Run Last' })
map('n', '<leader>dt', function()
    -- Check if dapui is visible before toggling
    local dapui_visible = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match 'dap%-' then
            dapui_visible = true
            break
        end
    end

    -- If dapui is not visible and we're about to open it, close NvimTree
    if not dapui_visible then
        -- Close NvimTree if it's open
        local nvim_tree = require 'nvim-tree.api'
        if nvim_tree.tree.is_visible() then
            nvim_tree.tree.close()
        end
    end

    require('dapui').toggle()
end, { desc = 'Toggle Debug UI' })

-- Disable mappings
local nomap = vim.keymap.del
