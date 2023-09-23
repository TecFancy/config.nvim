return {
  -- lua functions that many plugins are
  -- {
  --   "nvim-lua/plenary.nvim"
  -- },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },
  -- tmux
  {
    "christoomey/vim-tmux-navigator"
  },
  -- maximizes and restores current window
  {
    "szw/vim-maximizer"
  },
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
  }
}

