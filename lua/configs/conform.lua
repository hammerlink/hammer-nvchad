local utils = require 'utils'

local options = {
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = function()
            return utils.is_deno and { 'deno_fmt' } or { 'prettier' }
        end,
        javascriptreact = function()
            return utils.is_deno and { 'deno_fmt' } or { 'prettier' }
        end, -- for .jsx files
        typescript = function()
            return utils.is_deno and { 'deno_fmt' } or { 'prettier' }
        end,
        typescriptreact = function()
            return utils.is_deno and { 'deno_fmt' } or { 'prettier' }
        end, -- for .tsx files
        json = function()
            return utils.is_deno and { 'deno_fmt' } or { 'prettier' }
        end, -- for .tsx files
        vue = { 'prettier' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        mdx = { 'prettier' },
        svd = { 'prettier' },
        sql = { 'pg_format' },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },

    formatters = {
        prettier = {
            -- This will make prettier respect .prettierignore
            cwd = require('conform.util').root_file {
                '.prettierrc',
                '.prettierrc.json',
                '.prettierrc.js',
                'prettier.config.js',
            },
            -- Alternative: find git root
            -- cwd = require("conform.util").root_file(".git"),

            -- Explicitly tell prettier to use .prettierignore
            args = {
                '--ignore-path',
                '.prettierignore',
                -- Add your other prettier args here
                '--stdin-filepath',
                '$FILENAME',
            },
        },
        pg_format = {
            command = 'pg_format',
            args = { '--inplace' },
        },
    },

    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
}

return options
