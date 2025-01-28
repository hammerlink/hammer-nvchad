-- load defaults i.e lua_lsp
require('nvchad.configs.lspconfig').defaults()

local lspconfig = require 'lspconfig'

-- EXAMPLE
local servers = { 'html', 'cssls', 'clangd', 'rust_analyzer' }
local nvlsp = require 'nvchad.configs.lspconfig'

-- lsps with default config
for _, lsp in ipairs(servers) do
    local config = {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }

    -- Special configuration for rust-analyzer
    if lsp == 'rust_analyzer' then
        config.settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = 'clippy',
                },
                diagnostics = {
                    enable = true,
                    experimental = {
                        enable = true,
                    },
                },
            },
        }
    end

    lspconfig[lsp].setup(config)
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
