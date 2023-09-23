return {
  -- lualine(status line)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },
  -- tmux
  "christoomey/vim-tmux-navigator",
  -- maximizes and restores current window
  "szw/vim-maximizer",
  -- essential plugins
  -- {
  --   "tpope/vim-surround"
  -- },
  -- {
  --   "vim-scripts/ReplaceWithRegister"
  -- },
  -- commenting with gc
  {
    "numToStr/Comment.nvim",
    opts = {
        -- add any options here
    },
    lazy = false
  },
  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup ()
    end,
  },
  -- fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      -- lua functions that many plugins are
      "nvim-lua/plenary.nvim", -- reqired dependency
      "BurntSushi/ripgrep", -- suggested dependency: required for `live_grep` and `grep_string` and is the first priority for find_files
      "sharkdp/fd", -- optional dependency: finder
      -- "nvim-treesitter/nvim-treesitter" -- optional dependency: finder/preview
      -- "neovim LSP" optional dependency: picker
      "nvim-tree/nvim-web-devicons" -- optional dependency: icons
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              -- ["<C-q>"] = require("telescope.actions").move_selected_to_qflist + actioins.open_qflist -- this line is wrong!
            }
          }
        }
      })
    end,
  },
  -- autocompletion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",

  -- snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- managing & installing lsp servers
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- configuring lsp server 
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  { "glepnir/lspsaga.nvim", branch = "main" },
  "jose-elias-alvarez/typescript.nvim",
  "onsails/lspkind.nvim"
}

