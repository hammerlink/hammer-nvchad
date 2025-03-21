local M = {
    {
        'mfussenegger/nvim-dap',
        config = function() end,
        init = function()
            -- local dap = require 'dap'
            --
            -- -- Adapter configuration
            -- dap.adapters['pwa-node'] = {
            --
            --     type = 'server',
            --     host = '127.0.0.1',
            --     port = 53882, -- Port you saw
            --     -- type = 'executable',
            --     -- command = 'node',
            --     -- args = {
            --     --     '/home/hendrik/Programs/vscode-js-debug/dist/src/vsDebugServer.js',
            --     -- }, -- Adjust path if needed
            -- }
            -- -- Configuration for Node.js
            -- dap.configurations.javascript = {
            --     {
            --         type = 'pwa-node',
            --         request = 'launch',
            --         name = 'Launch file',
            --         program = '${file}', -- Debug the current file
            --         cwd = '${workspaceFolder}', -- Working directory
            --         runtimeExecutable = 'node', -- Use Node.js
            --     },
            --     {
            --         type = 'pwa-node',
            --         request = 'attach',
            --         name = 'Attach to process',
            --         processId = require('dap.utils').pick_process,
            --         cwd = '${workspaceFolder}',
            --     },
            -- }
            --
            -- -- Also add TypeScript configuration
            -- dap.configurations.typescript = dap.configurations.javascript
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            require('dapui').setup()
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup()
        end,
    },
    {
        'mxsdev/nvim-dap-vscode-js',
        dependencies = { 'mfussenegger/nvim-dap' },
        lazy = false,
        config = function()
            require('dap-vscode-js').setup {
                -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
                node_path = 'node',

                -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
                -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.

                debugger_path = '/home/hendrik/Programs/vscode-js-debug',
                adapters = { 'pwa-node' }, -- which adapters to register in nvim-dap
                -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
                -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
                -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
            }

            for _, language in ipairs { 'typescript', 'javascript' } do
                require('dap').configurations[language] = {
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = '${workspaceFolder}',
                        port = '${port}',
                    },
                    {
                        type = 'pwa-node',
                        request = 'attach',
                        name = 'Attach',
                        processId = require('dap.utils').pick_process,
                        cwd = '${workspaceFolder}',
                        port = '${port}',
                    },
                }
            end
        end,
    },
}

return M
