return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("neogit").setup {
        integrations = {
          diffview = true,
        },
        mappings = {
          popup = {
            ["g?"] = "HelpPopup",
            ["?"] = false,
          },
        },
      }
      vim.cmd "highlight NeogitDiffDelete gui=bold guifg=#FAEBE8 guibg=#D1321B"
      vim.cmd "highlight NeogitDiffDeleteCursor gui=bold guifg=#D1321B guibg=#FAEBE8"
      vim.cmd "highlight NeogitDiffDeleteHighlight gui=bold guifg=#FAEBE8 guibg=#D1321B"

      vim.cmd "highlight DiffviewDiffAddAsDelete guibg=#55433b guifg=NONE"
      vim.cmd "highlight DiffviewDiffDelete guibg=#533649 guifg=NONE"
      vim.cmd "highlight DiffviewDiffAdd guibg=#35533d guifg=NONE"
      vim.cmd "highlight DiffviewDiffChange guibg=#29446c guifg=NONE"
      vim.cmd "highlight DiffviewDiffText guibg=#3f426c guifg=NONE"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }

     -- or 
     -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  }
}
