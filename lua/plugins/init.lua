local neogit_plugin = require 'plugins.neogit'
local telescope_plugin = require 'plugins.telescope'
local avante_plugin = require 'plugins.avante'
local cmp_plugin = require 'plugins.cmp'
local overseer_plugin = require 'plugins.overseer'
local aerial_plugin = require 'plugins.aerial'

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

    -- {
    -- 	"nvim-treesitter/nvim-treesitter",
    -- 	opts = {
    -- 		ensure_installed = {
    -- 			"vim", "lua", "vimdoc",
    --      "html", "css"
    -- 		},
    -- 	},
    -- },
    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
        },
    },
    aerial_plugin,
    cmp_plugin,
    neogit_plugin,
    telescope_plugin,
    avante_plugin,
    overseer_plugin,
}
