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

-- Disable mappings
local nomap = vim.keymap.del
