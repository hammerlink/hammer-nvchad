local async = require 'neotest.async'
local lib = require 'neotest.lib'
local logger = require 'neotest.logging'


---@class neotest-deno.Config
---@field deno_cmd string Command to run deno
---@field root_files string[] Files indicating the root of a Deno project
---@field test_patterns string[] Glob patterns for test files
---@field filter_dir fun(name: string, rel_path: string, root: string): boolean Function to filter directories when searching for test files
---@field args string[] Extra arguments for deno test command
---@field env table<string, string> Environment variables for deno test command

---@type neotest-deno.Config
local default_config = {
    deno_cmd = 'deno',
    root_files = { 'deno.json', 'deno.jsonc', 'import_map.json' },
    test_patterns = { '**/*_test.{js,mjs,ts,jsx,tsx}', '**/*.test.{js,mjs,ts,jsx,tsx}' },
    filter_dir = function(name, _, _)
        return not vim.tbl_contains({ 'node_modules', '.git' }, name)
    end,
    args = {},
    env = {},
}

---@class neotest.Adapter
---@field name string
local NeotestAdapter = { name = 'neotest-deno' }

---Find the project root directory
function NeotestAdapter.root(path)
    return lib.files.match_root_pattern("deno.json")(path)
end

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function NeotestAdapter.filter_dir(name, rel_path, root)
    return default_config.filter_dir(name, rel_path, root)
end

---@param file_path? string
---@return boolean
function NeotestAdapter.is_test_file(file_path)
    if file_path == nil then
        print("File path is nil")
        return false
    end

    -- Check if file is in __tests__ directory
    if string.match(file_path, '__tests__') then
        return true
    end

    -- Check against configured test patterns
    for _, x in ipairs({ "test" }) do
      for _, ext in ipairs({ "ts", "tsx", "mts", "js", "mjs", "jsx" }) do
        if string.match(file_path, "%." .. x .. "%." .. ext .. "$") or
           string.match(file_path, "_" .. x .. "%." .. ext .. "$") then
            return true
        end
      end
    end

    print("File is not a test file")
    return false
end

---Parse the AST of a test file to get the test positions
---@async
---@param file_path string Absolute file path
---@return neotest.Tree|nil
function NeotestAdapter.discover_positions(file_path)
    local query = [[
    ; Basic Deno.test with a named function
    (call_expression
      function: (member_expression
        object: (identifier) @object (#eq? @object "Deno")
        property: (property_identifier) @property (#eq? @property "test")
      )
      arguments: (arguments
        (function_expression
          name: (identifier) @test.name
        ) @test.function
      )
    ) @test.definition

    ; Deno.test with a string name and function expression
    (call_expression
      function: (member_expression
        object: (identifier) @object (#eq? @object "Deno")
        property: (property_identifier) @property (#eq? @property "test")
      )
      arguments: (arguments
        (string (string_fragment) @test.name)
        (function_expression) @test.function
      )
    ) @test.definition

    ; Deno.test with just an anonymous function or arrow function
    (call_expression
      function: (member_expression
        object: (identifier) @object (#eq? @object "Deno")
        property: (property_identifier) @property (#eq? @property "test")
      )
      arguments: (arguments
        (string (string_fragment) @test.name)
        (arrow_function) @test.function
      )
    ) @test.definition

    ; Deno.test with options object
    (call_expression
      function: (member_expression
        object: (identifier) @object (#eq? @object "Deno")
        property: (property_identifier) @property (#eq? @property "test")
      )
      arguments: (arguments
        (object
          (pair
            key: (property_identifier) @key1 (#eq? @key1 "name")
            value: (string (string_fragment) @test.name)
          )
          (pair
            key: (property_identifier) @key2 (#eq? @key2 "fn")
            value: (arrow_function) @test.function
          )
          )
        )
      ) @test.definition
  ]]



    return lib.treesitter.parse_positions(file_path, query, { nested_tests = true })
end

---Build the command to run the test
---@param args neotest.RunArgs
---@return neotest.RunSpec|nil
function NeotestAdapter.build_spec(args)
    local position = args.tree:data()
    local file_path = position.path

    local command = {
        default_config.deno_cmd,
        'test',
        '--allow-all',
        '--unstable',
        '--no-check',
        '--json', -- Required for parsing results
    }

    -- Add any extra arguments from config
    for _, arg in ipairs(default_config.args) do
        table.insert(command, arg)
    end

    -- If we're running a specific test, add the filter
    if position.type == 'test' then
        local test_name = position.name
        -- Escape special characters in the test name for the filter
        test_name = test_name:gsub("([%(%)%.%[%]%*%+%-%?%$%^])", "\\%1")
        table.insert(command, '--filter')
        table.insert(command, test_name)
    end

    -- Add the file path
    table.insert(command, file_path)

    logger.info("Running Deno test command: " .. table.concat(command, " "))

    return {
        command = command,
        context = {
            file = file_path,
            position_id = position.id,
        },
        env = default_config.env,
    }
end

---Parse the output of the test command
---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function NeotestAdapter.results(spec, result, tree)
    local results = {}
    local position_id = spec.context.position_id
    local file_path = spec.context.file

    -- Default result in case parsing fails
    results[position_id] = {
        status = 'failed',
        short = 'Error parsing test results',
    }

    if result.code ~= 0 and not result.output then
        return results
    end

    -- Try to parse the JSON output
    local success, parsed = pcall(vim.json.decode, result.output)
    if not success or not parsed then
        logger.error('Failed to parse JSON output: ' .. (result.output or 'nil'))
        return results
    end

    logger.debug("Deno test results: " .. vim.inspect(parsed))

    -- Process the parsed results
    local function process_test_results(test_results, base_id)
        for _, test_result in ipairs(test_results or {}) do
            local test_name = test_result.name
            if not test_name then
                logger.error("Test result missing name: " .. vim.inspect(test_result))
                goto continue
            end

            local test_id = base_id .. '::' .. test_name

            local status = 'failed'
            if test_result.ok then
                status = 'passed'
            elseif test_result.skipped then
                status = 'skipped'
            end

            results[test_id] = {
                status = status,
                short = test_result.message or '',
                output = test_result.output or '',
                errors = test_result.error and { { message = test_result.error } } or nil,
            }

            ::continue::
        end
    end

    -- Handle different JSON output formats from Deno
    if parsed.testResults then

        process_test_results(parsed.testResults, position_id)
    elseif parsed.tests then

        process_test_results(parsed.tests, position_id)
    elseif type(parsed) == "table" and #parsed > 0 then
        -- Deno sometimes outputs an array of test results
        process_test_results(parsed, position_id)
    else
        -- If we can't find structured results, set the file result based on exit code
        results[position_id] = {
            status = result.code == 0 and 'passed' or 'failed',
            output = result.output,
        }
    end

    return results
end

---@param config neotest-deno.Config
local function setup(config)
    config = vim.tbl_deep_extend('force', default_config, config or {})

    -- Update the default config with user settings
    default_config = config

    return NeotestAdapter
end

return setup
