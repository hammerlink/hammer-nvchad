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

-- LSP
map('n', '<leader>li', '<cmd> LspInfo <cr>', { desc = 'LSP Info' })
map('n', '<leader>lr', '<cmd> LspRestart <cr>', { desc = 'LSP Restart' })

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

-- Disable mappings
local nomap = vim.keymap.del
