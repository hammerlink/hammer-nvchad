local cmp = require "cmp"
local M = {}

M.mapping = {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-x>"] = cmp.mapping.close(),
}

return M
