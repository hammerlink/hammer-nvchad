local M = {}

M.CargoQuickfix = function()
    -- Get the full path of the current buffer
    local current_buffer_path = vim.fn.expand '%:p'

    -- Get the directory of the current buffer
    local buffer_dir = vim.fn.expand('%:p:h')
    -- Save current working directory
    local cwd = vim.fn.getcwd()
    -- Change to buffer directory
    vim.cmd('cd ' .. buffer_dir)
    -- Execute cargo check
    local output = vim.fn.systemlist 'cargo check --message-format=json'
    -- Restore original working directory
    vim.cmd('cd ' .. cwd)
    local qflist = {}

    for _, line in ipairs(output) do
        local ok, parsed = pcall(vim.json.decode, line)
        if ok and parsed.reason == 'compiler-message' then
            -- Check if we have spans and they're not empty
            if parsed.message.spans and #parsed.message.spans > 0 then
                local span = parsed.message.spans[1]
                local file_path = span.file_name
                -- Get absolute path for the cargo file
                local abs_file_path = vim.fn.fnamemodify(file_path, ':p')


                -- Check if this is the current buffer's file
                if abs_file_path == current_buffer_path then
                    table.insert(qflist, {
                        filename = file_path,
                        lnum = span.line_start,
                        col = span.column_start,
                        text = parsed.message.message,
                        type = parsed.message.level,
                    })
                end
            end
        end
    end

    vim.fn.setqflist(qflist)
    vim.cmd 'copen'
end

return M
