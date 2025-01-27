return {
    'nvim-telescope/telescope.nvim',
    opts = function(_, conf)
        conf.defaults.mappings.i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-b>'] = require('telescope.actions').delete_buffer,
            ['<Esc>'] = require('telescope.actions').close,
        }

        return conf
    end,
}
