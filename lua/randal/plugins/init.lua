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

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = function ()
      require("nvim-treesitter.install").update({ with_sync = true })
    end
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
      "nvim-treesitter/nvim-treesitter", -- optional dependency: finder/preview
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
  {
    "neovim/nvim-lspconfig",
    dependencies = { "nvimdev/lspsaga.nvim", branch = "main" }
  },
  "hrsh7th/cmp-nvim-lsp",
  -- { "glepnir/lspsaga.nvim", branch = "main" },
  -- { "nvimdev/lspsaga.nvim", branch = "main" },
  "jose-elias-alvarez/typescript.nvim",
  "onsails/lspkind.nvim",

  -- auto clsing
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

  -- git signs plugin
  "lewis6991/gitsigns.nvim",

  -- debug
  -- "puremourning/vimspector"

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
      -- build debugger from source
      {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
      }
    },
    keys = {
      -- normal mode is default
      { "<leader>dd", function() require 'dap'.toggle_breakpoint() end },
      { "<leader>dc", function() require 'dap'.continue() end },
      { "<C-'>",     function() require 'dap'.step_over() end },
      { "<C-;>",     function() require 'dap'.step_into() end },
      { "<C-:>",     function() require 'dap'.step_out() end },
    },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "svelte" }) do
        require("dap").configurations[language] = {
          -- attach to a node process that has been started with
          -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
          -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = "pwa-node",
            -- attach to an already running node process with --inspect flag
            -- default port: 9222
            request = "attach",
            -- allows us to pick the process using a picker
            processId = require 'dap.utils'.pick_process,
            -- name of the debug action you have to select for this config
            name = "Attach debugger to existing `node --inspect` process",
            -- for compiled languages like TypeScript or Svelte.js
            sourceMaps = true,
            -- resolve source maps in nested locations while ignoring node_modules
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**" },
              -- path to src in vite based projects (and most other projects as well)
              cwd = "${workspaceFolder}/src",
              -- we don't want to debug code inside node_modules, so skip it!
              skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
            },
            {
              type = "pwa-chrome",
              name = "Launch Chrome to debug client",
						request = "launch",
						url = "http://localhost:3000",
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}/src",
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
					-- only if language is javascript, offer this debug action
					language == "javascript" and {
						-- use nvim-dap-vscode-js's pwa-node debug adapter
						type = "pwa-node",
						-- launch a new process to attach the debugger to
						request = "launch",
						-- name of the debug action you have to select for this config
						name = "Launch file in new node process",
						-- launch current file
						program = "${file}",
						cwd = "${workspaceFolder}",
					} or nil,
				}
			end
	
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({ reset = true })
			end
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end
	}

  -- {
  --   "mfussenegger/nvim-dap",
  --   lazy = true,
  --   dependencies = {
  --     "rcarriga/nvim-dap-ui",
  --     "mxsdev/nvim-dap-vscode-js",
  --     -- lazy spec to build "microsoft/vscode-js-debug" from source
  --     {
  --       "microsoft/vscode-js-debug",
  --       version = "1.x",
  --       build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
  --     }
  --   },
  --   keys = {
  --     { "<leader>dd", function() require('dap').toggle_breakpoint() end },
  --     { "<leader>dc", function() require('dap').continue() end },
  --   },
  --   -- config = function()
  --   --   require("dapui").setup()
  --   -- end,
  --   config = function()
  --     require("dap-vscode-js").setup({
  --       debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
  --       adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  --     })
  --     require("dapui").setup()
  --
  --     for _, language in ipairs({ "typescript", "javascript", "svelte", "typescriptreact" }) do
  --       require("dap").configurations[language] = {
  --         -- config goes here
  --         -- Launch current file in new node process
  --         {
  --           -- use nvim-dap-vscode-js's pwa-node debug adapter
  --           type = "pwa-node",
  --           -- launch a new process to attach the debugger to
  --           request = "launch",
  --           -- name of the debug action you have to select for this config
  --           name = "Launch current file in new node process",
  --           program = "${file}",
  --         },
  --         -- Attach to an inspectable node process
  --         -- e.g., 
  --         -- # start SvelteKit dev server with inspectable node process
  --         -- npm --node-options --inspect-brk run dev
  --         -- npm --node-options --inspect run dev
  --         {
  --           -- use nvim-dap-vscode-js's pwa-node debug adapter
  --           type = "pwa-node",
  --           -- attach to an already running node process with --inspect flag
  --           -- default port: 9222
  --           request = "attach",
  --           -- allows us to pick the process using a picker
  --           processId = require 'dap.utils'.pick_process,
  --           -- name of the debug action
  --           name = "Attach debugger to existing `node --inspect` process",
  --           -- for compiled languages like TypeScript or Svelte.js
  --           sourceMaps = true,
  --           -- resolve source maps in nested locations while ignoring node_modules
  --           resolveSourceMapLocations = { "${workspaceFolder}/**",
  --           "!**/node_modules/**"},
  --           -- path to src in vite based projects (and most other projects as well)
  --           cwd = "${workspaceFolder}/src",
  --           -- we don't want to debug code inside node_modules, so skip it!
  --           skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
  --         },
  --         -- Debug the web in google chrome
  --         {
  --           -- use nvim-dap-vscode-js's pwa-chrome debug adapter
  --           type = "pwa-chrome",
  --           request = "launch",
  --           -- name of the debug action
  --           name = "Launch Chrome to debug client side code",
  --           -- default vite dev server url
  --           url = "http://localhost:3000",
  --           -- for TypeScript/Svelte
  --           sourceMaps = true,
  --           webRoot = "${workspaceFolder}/src",
  --           protocol = "inspector",
  --           port = 9222,
  --           -- skip files from vite's hmr
  --           skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
  --         },
  --       }
  --     end
  --
  --     local dap, dapui = require("dap"), require("dapui")
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open({ reset = true })
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = dapui.close
  --     dap.listeners.before.event_exited["dapui_config"] = dapui.close
  --   end
  -- }

  -- {
  --   "mfussenegger/nvim-dap",
  --   "Pocco81/DAPInstall.nvim",
  --   "theHamsta/nvim-dap-virtual-text",
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = {
  --     "typescript-language-server/typescript-language-server",
  --     { "mxsdev/nvim-dap-vscode-js", dependencies = "mfussenegger/nvim-dap" },
  --     {
  --       "microsoft/vscode-js-debug",
  --       opt = true,
  --       run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  --     }
  --   }
  -- }
}

