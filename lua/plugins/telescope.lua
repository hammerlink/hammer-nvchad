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
        conf.defaults.vimgrep_arguments = {
            'rg',
            '-L',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        }
        conf.defaults.file_sorter = require("telescope.sorters").get_fuzzy_file
        conf.defaults.file_ignore_patterns = { "node_modules" }
        conf.defaults.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter

        return conf
    end,
}
