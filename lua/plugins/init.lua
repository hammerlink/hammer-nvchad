local neogit_plugin = require 'plugins.neogit'
local telescope_plugin = require 'plugins.telescope'
local avante_plugin = require 'plugins.avante'
local cmp_plugin = require 'plugins.cmp'
local overseer_plugin = require 'plugins.overseer'
local aerial_plugin = require 'plugins.aerial'
local copilot_plugin = require 'plugins.copilot'
local diffview_plugin = require 'plugins.diffview'
local neotest_plugin = require 'plugins.neotest'
local notify_plugin = require 'plugins.notify'
local dap_plugin = require 'plugins.dap'
local rustacean_plugin = require 'plugins.rustacean'

return {
    {
        'stevearc/conform.nvim',
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require 'configs.conform',
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'configs.lspconfig'
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'vim',
                'lua',
                'vimdoc',
                'html',
                'css',
                'rust',
                'javascript',
                'typescript',
                'c',
                'markdown',
                'vue',
            },
        },
    },
    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
        },
    },
    { 'mbbill/undotree', cmd = 'UndotreeToggle' },
    notify_plugin,
    aerial_plugin,
    cmp_plugin,
    diffview_plugin,
    neogit_plugin,
    telescope_plugin,
    avante_plugin,
    overseer_plugin,
    copilot_plugin,
    neotest_plugin,
    dap_plugin,
    rustacean_plugin,
}
