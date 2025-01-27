local M = {
    {
        'hrsh7th/nvim-cmp',
        opts = function()
            local cmp = require 'nvchad.configs.cmp'
            local custom_cmp = require 'configs.cmp'

            -- Merge the custom mappings with default ones
            cmp.mapping = vim.tbl_deep_extend('force', cmp.mapping, custom_cmp.mapping)

            return cmp
        end,
    },
}

return M
