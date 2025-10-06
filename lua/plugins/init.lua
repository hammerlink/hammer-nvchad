local neogit_plugin = require "plugins.neogit"
local notify_plugin = require "plugins.notify"
local telescope_plugin = require "plugins.telescope"
local neotest_plugin = require "plugins.neotest"

return {
    telescope_plugin,
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
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
    notify_plugin,
    neogit_plugin,
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    neotest_plugin,
}
