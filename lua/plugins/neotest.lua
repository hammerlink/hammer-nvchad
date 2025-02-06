local find_closest_package_json_dir = function(start_path, default_value)
    -- Get the current buffer's full path
    local path = start_path
    if not path then
        path = vim.fn.expand '%:p'
    end

    -- Extract the directory from the path
    local dir = vim.fn.fnamemodify(path, ':h')

    -- Keep searching until reaching the root directory
    while dir ~= '/' do
        local package_json_path = dir .. '/package.json'
        -- Check if package.json exists in this directory
        if vim.fn.filereadable(package_json_path) ~= 0 then
            return dir
        end
        -- Move up one directory
        dir = vim.fn.fnamemodify(dir, ':h')
    end

    return default_value -- package.json not found
end
local M = {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    cmd = 'Neotest',
    config = function()
        require('neotest').setup {
            adapters = {
                require 'neotest-vitest' {
                    cwd = function(path)
                        local closest_dir = find_closest_package_json_dir(path, vim.fn.getcwd())
                        return closest_dir
                    end,
                },
            },
        }
    end,
}
return M
