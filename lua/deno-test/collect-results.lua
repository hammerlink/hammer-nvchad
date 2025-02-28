local lib = require 'neotest.lib'

--- This tries to find the position in the tree that belongs to this test case
--- result from the JUnit report XML. Therefore it parses the location from the
--- node attributes and compares it with the position information in the tree.
---
--- @param tree table - see neotest.Tree
--- @param test_case_node table - XML node of test case result
--- @return table | nil - see neotest.Position
local function find_position_for_test_case(tree, test_case_node)
    local cwd = vim.loop.cwd()
    local test_path = cwd .. '/' .. test_case_node._attr.classname:gsub('^%./', '')

    -- print(test_path)
    --     example test_case_node
    -- {
    --   _attr = {
    --     classname = "./second_test.ts",
    --     col = "6",
    --     line = "4",
    --     name = "secondTest",
    --     time = "1.001"
    --   }
    -- }
    for _, position in tree:iter() do
        -- example position
        -- position
        -- {
        --   id = "/home/hendrik/Projects/deno-dap/second_test.ts::secondTest",
        --   name = "secondTest",
        --   path = "/home/hendrik/Projects/deno-dap/second_test.ts",
        --   range = { 3, 0, 7, 2 },
        --   type = "test"
        -- }

        -- print 'position'
        -- print(vim.inspect(position))
        if position.name and position.name == test_case_node._attr.name and position.path == test_path then
            return position
        end
    end
end

local strip_ansi = function(str)
    if not str then
        return nil
    end
    -- Pattern to match ANSI escape sequences
    local pattern = '\27%[[^m]*m'
    -- Replace all ANSI sequences with empty string
    local result = string.gsub(str, pattern, '')
    -- Also remove carriage returns
    result = string.gsub(result, '\r', '')
    return result
end

--- See Neotest adapter specification.
---
--- This builds a list of test run results. Therefore it parses all JUnit report
--- files and traverses trough the reports inside. The reports are matched back
--- to Neotest positions.
--- It also tries to determine why and where a test possibly failed for
--- additional Neotest features like diagnostics.
---
--- @param build_specfication table - see neotest.RunSpec
--- @param tree table - see neotest.Tree
--- @return table<string, table> - see neotest.Result
return function(build_specfication, result, tree)
    local results = {}
    local position_id = build_specfication.context.position_id
    -- position_id /home/hendrik/Projects/deno-dap/second_test.ts::secondTest

    -- Default result in case parsing fails
    results[position_id] = {
        status = 'failed',
        short = 'Error parsing test results',
    }

    if result.code ~= 0 and not result.output then
        return results
    end

    local position = tree:data()

    local status_counts = {
        passed = 0,
        failed = 0,
        skipped = 0,
    }

    print(result.output)
    -- Get the directory of the current file
    local current_file = debug.getinfo(1, 'S').source:sub(2)
    local current_dir = current_file:match '(.*/)'
    local output = vim.fn.system('deno run --allow-read ' .. current_dir .. 'parse-deno-test-output.ts ' .. result.output)

    local parsed_output = vim.fn.json_decode(output)
    print(vim.inspect(parsed_output))
    -- local raw_content = lib.files.read(result.output)
    -- print(raw_content)
    -- local content = strip_ansi(raw_content)
    -- print(content)
    -- print(vim.inspect(parse_content(content)))

    -- example content
    -- secondTest ...
    ------- output -------
    -- custom log
    -- custom log 1
    -- ----- output end -----
    -- secondTest ... FAILED (1ms)
    -- secondXTest ...
    -- ------- output -------
    -- x x x
    -- ----- output end -----
    -- secondXTest ... ok (0ms)
    -- secondYTest ... ignored (0ms)

    -- local junit_reports = parse_xml_file(result.output)

    --- Keep track of total number of tests that passed, failed, and were skipped.
    --
    -- for _, junit_report in pairs(junit_reports) do
    --     for _, test_suite_node in pairs(as_list(junit_report.testsuite)) do
    --         for _, test_case_node in pairs(as_list(test_suite_node.testcase)) do
    --             local matched_position = find_position_for_test_case(tree, test_case_node)
    --
    --             if matched_position ~= nil then
    --                 local failure_node = test_case_node.failure
    --                 local status
    --
    --                 if failure_node == nil then
    --                     status = 'passed'
    --                     status_counts.passed = status_counts.passed + 1
    --                 else
    --                     status = 'failed'
    --                     status_counts.failed = status_counts.failed + 1
    --                 end
    --
    --                 local short_message = (failure_node or {}).message
    --                 local error = failure_node and parse_error_from_failure_xml(failure_node, position)
    --                 local result = { status = status, short = short_message, errors = { error } }
    --                 results[matched_position.id] = result
    --             end
    --         end
    --     end
    -- end
    --
    -- -- Notify the user with the summary of test results
    -- local summary_message = string.format(
    --     'Test Results: %d passed, %d failed, %d skipped',
    --     status_counts.passed,
    --     status_counts.failed,
    --     status_counts.skipped
    -- )
    -- local log_level = status_counts.failed > 0 and vim.log.levels.ERROR or vim.log.levels.INFO
    -- vim.notify(summary_message, log_level)

    return results
end
