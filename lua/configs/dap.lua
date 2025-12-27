local dap = require "dap"

-- Set up custom signs with icons
vim.fn.sign_define("DapBreakpoint", {
    text = "🔴",
    texthl = "DapBreakpoint",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapBreakpointCondition", {
    text = "🟡",
    texthl = "DapBreakpoint",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapStopped", {
    text = "▶️",
    texthl = "DapStopped",
    linehl = "DapStopped",
    numhl = "DapStopped",
})
-- Keep your existing GDB adapters
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.adapters["rust-gdb"] = {
    type = "executable",
    command = "rust-gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

-- Add CodeLLDB adapter (better for Rust)
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

-- Improved Rust-specific configurations
dap.configurations.rust = {
    {
        name = "Launch Rust Binary",
        type = "codelldb",
        request = "launch",
        program = function()
            -- Try to find target/debug/ binaries first
            local handle = io.popen "find target/debug -maxdepth 1 -type f -executable 2>/dev/null"
            if handle then
                local result = handle:read "*a"
                handle:close()
                if result and result ~= "" then
                    local binaries = {}
                    for binary in result:gmatch "[^\r\n]+" do
                        if #binaries == 1 then
                            return binaries[1]
                        elseif #binaries > 1 then
                            return vim.fn.inputlist(vim.list_extend({ "Select binary:" }, binaries))
                        end
                    end
                end
            end
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
    {
        name = "Launch Cargo Test",
        type = "codelldb",
        request = "launch",
        program = function()
            local handle =
                io.popen 'cargo test --no-run --message-format=json 2>/dev/null | jq -r \'select(.target.kind[] == "bin" or .target.kind[] == "test") | .executable\' | head -1'
            if handle then
                local result = handle:read("*a"):gsub("\n", "")
                handle:close()
                if result and result ~= "" then
                    return result
                end
            end
            return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/deps/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
    {
        name = "Launch with rust-gdb",
        type = "rust-gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        args = {},
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Attach to Rust Process",
        type = "codelldb",
        request = "attach",
        pid = function()
            return require("dap.utils").pick_process { filter = "rust" }
        end,
        cwd = "${workspaceFolder}",
    },
}

-- DAP UI setup
local dapui = require "dapui"
dapui.setup()

-- Auto-open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
