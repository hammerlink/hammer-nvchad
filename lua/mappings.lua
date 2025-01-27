require 'nvchad.mappings'

-- add yours here

local map = vim.keymap.set

-- escape modus
map('i', 'fd', '<ESC>', { desc = 'custom escape' })
map('v', 'fd', '<ESC>', { desc = 'custom escape' })
map('n', '<leader>tx', '<cmd> tabclose <CR>', { desc = 'Tab close' })

-- neogit
map('n', '<leader>gg', '<cmd> Neogit <cr>', { desc = 'Open NeoGit' })

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

-- Avante
map('n', '<leader>ax', '<cmd> AvanteClear <cr>', { desc = 'Avante Clear' })

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

-- Disable mappings
local nomap = vim.keymap.del
