local neogit_plugin = require "plugins.neogit"
local notify_plugin = require "plugins.notify"
local telescope_plugin = require "plugins.telescope"
local neotest_plugin = require "plugins.neotest"
local diffview_plugin = require "plugins.diffview"

return {
    telescope_plugin,
    { "stevearc/dressing.nvim", lazy = false },
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function()
            local cmp = require "nvchad.configs.cmp"
            local custom_cmp = require "configs.cmp"

            -- Merge the custom mappings with default ones
            cmp.mapping = vim.tbl_deep_extend("force", cmp.mapping, custom_cmp.mapping)

            return cmp
        end,
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                -- 'lua',
                "vimdoc",
                "html",
                "css",
                "rust",
                "javascript",
                "typescript",
                "c",
                "markdown",
                "vue",
            },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
        },
    },
    notify_plugin,
    diffview_plugin,
    neogit_plugin,
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    neotest_plugin,
    {
        "stevearc/aerial.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = "AerialToggle",
        config = function()
            require("aerial").setup {
                layout = {
                    default_direction = "prefer_right",
                },
            }
        end,
    },
}
