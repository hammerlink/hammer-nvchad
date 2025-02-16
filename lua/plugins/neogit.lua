local M = {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
    },
    cmd = "Neogit",
    config = function()
        -- Configure notify to avoid background warning

        require('neogit').setup {
            integrations = {
                diffview = true,
            },
            mappings = {
                popup = {
                    ['g?'] = 'HelpPopup',
                    ['?'] = false,
                },
            },
        }
        vim.cmd 'highlight NeogitDiffDelete gui=bold guifg=#FAEBE8 guibg=#D1321B'
        vim.cmd 'highlight NeogitDiffDeleteCursor gui=bold guifg=#D1321B guibg=#FAEBE8'
        vim.cmd 'highlight NeogitDiffDeleteHighlight gui=bold guifg=#FAEBE8 guibg=#D1321B'

        vim.cmd 'highlight DiffviewDiffAddAsDelete guibg=#55433b guifg=NONE'
        vim.cmd 'highlight DiffviewDiffDelete guibg=#533649 guifg=NONE'
        vim.cmd 'highlight DiffviewDiffAdd guibg=#35533d guifg=NONE'
        vim.cmd 'highlight DiffviewDiffChange guibg=#29446c guifg=NONE'
        vim.cmd 'highlight DiffviewDiffText guibg=#3f426c guifg=NONE'
    end,
}

return M
