-- load defaults i.e lua_lsp
require('nvchad.configs.lspconfig').defaults()

local lspconfig = require 'lspconfig'

-- Define a function to check if a Deno project is detected
local function is_deno_project()
    return lspconfig.util.root_pattern('deno.json', 'deno.jsonc')(vim.fn.getcwd()) ~= nil
end

local servers = { 'html', 'cssls', 'clangd', 'rust_analyzer', 'vuels' }
if is_deno_project() then
    table.insert(servers, 'denols')
    vim.notify('Deno project detected: Using denols language server', vim.log.levels.INFO)
else
    table.insert(servers, 'ts_ls')
    print 'Using TypeScript language server (ts_ls)'
end

local nvlsp = require 'nvchad.configs.lspconfig'

-- Store the original on_attach
local map = vim.keymap.set
local custom_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = 'LSP ' .. desc }
    end

    map('n', 'gD', vim.lsp.buf.declaration, opts 'Go to declaration')

    map('n', 'gd', function()
        vim.lsp.buf.definition {
            on_list = function(options)
                if #options.items == 1 then
                    return vim.lsp.buf.definition()
                end
                return require('telescope.builtin').lsp_definitions()
            end,
        }
    end, opts 'LSP Definition')

    map('n', 'gi', vim.lsp.buf.implementation, opts 'Go to implementation')
    map('n', '<leader>sh', vim.lsp.buf.signature_help, opts 'Show signature help')
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts 'Add workspace folder')
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts 'Remove workspace folder')

    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts 'List workspace folders')

    map('n', '<leader>D', vim.lsp.buf.type_definition, opts 'Go to type definition')
    map('n', '<leader>ra', require 'nvchad.lsp.renamer', opts 'NvRenamer')

    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts 'Code action')
    map('n', 'gr', '<cmd> Telescope lsp_references <cr>', opts 'Show references')
end

-- lsps with default config
for _, lsp in ipairs(servers) do
    local config = {
        on_attach = custom_attach,
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
