local cmp = require "cmp"
local M = {}

-- Helper to trigger completion filtered by one or more kinds
local function complete_with_kind(kinds)
    -- Ensure kinds is always a table
    if type(kinds) ~= "table" then
        kinds = { kinds }
    end

    local kind_set = {}
    for _, kind in ipairs(kinds) do
        kind_set[kind] = true
    end

    cmp.complete {
        config = {
            sources = {
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry)
                        return kind_set[entry:get_kind()] == true
                    end,
                },
                {
                    name = "luasnip",
                    entry_filter = function(entry)
                        return kind_set[entry:get_kind()] == true
                    end,
                },
            },
        },
    }
end

M.mapping = {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-x>"] = cmp.mapping.close(),
    ["<C-f>"] = cmp.mapping(function()
        complete_with_kind(cmp.lsp.CompletionItemKind.Field)
    end, { "i", "c" }),
    ["<C-g>"] = cmp.mapping(function()
        complete_with_kind {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
        }
    end, { "i", "c" }),
    ["<C-s>"] = cmp.mapping(function()
        complete_with_kind(cmp.lsp.CompletionItemKind.Snippet)
    end, { "i", "c" }),
    -- 🔹 Reset filter — show everything again
    ["<C-r>"] = cmp.mapping(function()
        cmp.complete() -- no filter, restores normal behavior
    end, { "i", "c" }),
}

return M
