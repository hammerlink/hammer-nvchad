local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        typescript = { "deno_fmt" },
        typescriptreact = { "deno_fmt" },
        javascript = { "deno_fmt" },
        javascriptreact = { "deno_fmt" },
        json = { "deno_fmt" },
        markdown = { "deno_fmt" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },

    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
}

return options
