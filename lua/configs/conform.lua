local options = {
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        vue = { 'prettier' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
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
    },

    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
}

return options
