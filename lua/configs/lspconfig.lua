require("nvchad.configs.lspconfig").defaults()

local servers = { "lua_ls", "denols", "clangd", "pyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
