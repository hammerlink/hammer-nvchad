-- load defaults i.e lua_lsp
require('nvchad.configs.lspconfig').defaults()
local utils = require 'utils'

local servers = { 'html', 'cssls', 'clangd', 'vuels', 'perlls' } --, 'rust_analyzer'
if utils.is_deno then
    table.insert(servers, 'denols')
    print 'Using Deno language server (denols)'
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

    if lsp == 'denols' then
        vim.lsp.config('denols', {
            root_markers = { 'deno.json', 'deno.jsonc' },
            init_options = {
                enable = true,
                lint = true,
                unstable = false,
            },
        })
    else
        vim.lsp.config(lsp, config);
    end

    vim.lsp.enable(lsp)
end

