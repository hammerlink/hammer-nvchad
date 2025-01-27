local M = {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    cmd = 'AerialToggle',
    config = function()
        require('aerial').setup {
            layout = {
                default_direction = 'prefer_right',
            },
        }
    end,
}
return M
