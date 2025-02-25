local enabled_tools = {
    'read_file',
    'list_files',
    'search_files',
    'search_keyword',
    'web_search',
}

local tools = require 'avante.llm_tools'
local all_tools = tools.get_tools()

-- Create a lookup table for enabled tools for faster checking
local enabled_tools_lookup = {}
for _, tool_name in ipairs(enabled_tools) do
    enabled_tools_lookup[tool_name] = true
end

for i, tool in ipairs(all_tools) do
    -- Set tool.enabled to false if not in the enabled_tools list
    if not enabled_tools_lookup[tool.name] then
        tool.enabled = false
    end
end
