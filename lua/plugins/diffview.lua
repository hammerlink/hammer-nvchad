local M = {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewRefresh', 'DiffviewClose' },
    config = function()
        local actions = require 'diffview.actions'
        require('diffview').setup {
            keymaps = {
                view = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
                diff1 = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
                diff2 = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
                diff3 = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
                diff4 = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
                file_panel = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
                file_history_panel = { { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'close' } } },
            },
        }
    end,
}

return M
