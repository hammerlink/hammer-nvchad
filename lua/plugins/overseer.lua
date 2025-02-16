local M = {
    'hammerlink/overseer.nvim',
    opts = {},
    dependencies = {
        {
            'stevearc/dressing.nvim',
            dependencies = {
                { 'rcarriga/nvim-notify' },
            },
            opts = {},
        },
    },
    init = function()
        require 'configs.overseer'
    end,
}

return M
