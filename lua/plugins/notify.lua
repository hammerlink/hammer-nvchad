local M = {
    {
        'rcarriga/nvim-notify',
        opts = function()
            require('notify').setup {
                background_colour = '#1a1b26', -- You can adjust this hex color to match your theme
            }
            vim.notify = require 'notify'
        end,
    },
}

return M
