return {
    'nvim-telescope/telescope.nvim',
    opts = function(_, conf)
        conf.defaults.mappings.i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-b>'] = require('telescope.actions').delete_buffer,
            ['<C-x>'] = require('telescope.actions').close,
            ['<Esc>'] = require('telescope.actions').close,
            ['<C-s>'] = require('telescope.actions').file_split,
        }

        return conf
    end,
}
