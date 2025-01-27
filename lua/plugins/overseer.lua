local M = {
    'hammerlink/overseer.nvim',
    opts = {},
    dependencies = {
        {
            'stevearc/dressing.nvim',
            dependencies = {
                {
                    'rcarriga/nvim-notify',
                    config = function()
                        vim.notify = require 'notify'
                    end,
                },
            },
            opts = {},
        },
    },
    init = function()
        require 'configs.overseer'
    end,
}

return M
