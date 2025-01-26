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
    require 'lua.plugins.neogit',
    {
        'nvim-telescope/telescope.nvim',
        opts = function(_, conf)
            conf.defaults.mappings.i = {
                ['<C-j>'] = require('telescope.actions').move_selection_next,
                ['<Esc>'] = require('telescope.actions').close,
            }

            -- or
            -- table.insert(conf.defaults.mappings.i, your table)
            return conf
        end,
    },
}
