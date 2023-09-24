local fn = vim.fn

local dap_status, dap = pcall(require, "dap")
if not dap_status then
  return
end

local dap_vscode_js_status, dap_vscode_js_setup = pcall(require, "dap-vscode-js")
if not dap_vscode_js_status then
  return
end

dap_vscode_js_setup.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = { "./js-debug/src/dapDebugServer.js", "${port}" },
  }
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
  dap.configurations[language] = {
    -- Node.js
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    -- Jest
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    -- Mocha
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Mocha Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/mocha/bin/mocha.js",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    }
  }
end

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  -- 💀 Make sure to update this path to point to your installation
  args = { "./js-debug/src/dapDebugServer.js", "${port}" }
}

dap.configurations.typescript = {
  {
    type = 'node2',
    request = 'attach',
    name = 'Attach to TypeScript Server',
    protocol = 'inspector',
    port = 9229,
    cwd = fn.getcwd(),
    sourceMaps = true,
    skipFiles = {'<node_internals>/**/*.js'}
  }
}

-- Set keymaps to control the debugger
local keymap = vim.keymap
keymap.set('n', '<F5>', require 'dap'.continue)
keymap.set('n', '<F10>', require 'dap'.step_over)
keymap.set('n', '<F11>', require 'dap'.step_into)
keymap.set('n', '<F12>', require 'dap'.step_out)
keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
keymap.set('n', '<leader>B', function()
  require 'dap'.set_breakpoint(fn.input('Breakpoint condition: '))
end)

-- local fn = vim.fn
--
-- local dap_status, dap = pcall(require, "dap")
-- if not dap_status then
--   return
-- end
--
-- local dapui_status, dapui = pcall(require, "dapui")
-- if not dapui_status then
--   return
-- end
--
-- local dap_virtual_text_status, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
-- if not dap_virtual_text_status then
--   return
-- end
-- dap_virtual_text.setup({ commented = true })
--
-- -- 定义各种图标
--
-- fn.sign_define("DapBreakpoint", {
--   text = "🛑",
--   texthl = "LspDiagnosticsSignError",
--   linehl = "",
--   numhl = "",
-- })
--
-- fn.sign_define("DapStopped", {
--   text = "",
--   texthl = "LspDiagnosticsSignInformation",
--   linehl = "DiagnosticUnderlineInfo",
--   numhl = "LspDiagnosticsSignInformation",
-- })
--
-- fn.sign_define("DapBreakpointRejected", {
--   text = "",
--   texthl = "LspDiagnosticsSignHint",
--   linehl = "",
--   numhl = "",
-- })
--
-- dapui.setup({
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     -- Use a table to apply multiple mappings
--     expand = { "o", "<CR>", "<2-LeftMouse>" },
--     open = "o",
--     remove = "d",
--     edit = "e",
--     repl = "r",
--     toggle = "t",
--   },
--   sidebar = {
--     -- You can change the order of elements in the sidebar
--     elements = {
--       -- Provide as ID strings or tables with "id" and "size" keys
--       {
--         id = "scopes",
--         size = 0.25, -- Can be float or integer > 1
--       },
--       { id = "breakpoints", size = 0.25 },
--       { id = "stacks", size = 0.25 },
--       { id = "watches", size = 00.25 },
--     },
--     size = 40,
--     position = "left", -- Can be "left", "right", "top", "bottom"
--   },
--   tray = {
--     elements = { "repl" },
--     size = 10,
--     position = "bottom", -- Can be "left", "right", "top", "bottom"
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil, -- Floats will be treated as percentage of your screen.
--     border = "single", -- Border style. Can be "single", "double" or "rounded"
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
--   render = {
--     max_type_length = nil, -- Can be integer or nil.
--   },
-- }) -- use default
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- 绑定 nvim-dap 快捷键
-- require("keybindings").mapDAP()

--
-- dap.adapters["pwa-node"] = {
--   type = "server",
--   host = "localhost",
--   port = "${port}",
--   executable = {
--     command = "node",
--     -- 💀 Make sure to update this path to point to your installation
--     args = {"/path/to/js-debug/src/dapDebugServer.js", "${port}"},
--   }
-- }
--
-- dap.configurations.javascript = {
--   {
--     type = "pwa-node",
--     request = "launch",
--     name = "Launch file",
--     program = "${file}",
--     cwd = "${workspaceFolder}",
--   },
-- }

-- local js_status, js = pcall(require, "dap-vscode-js")
-- if not js_status then
--   return
-- end
--
-- local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/dap/vscode-js-debug"
--
-- js.setup({
--   node_path = "node",
--   debugger_path = DEBUGGER_PATH,
--   -- debugger_cmd = { "js-debug-adapter" },
--   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
-- })
--
-- local dap_status, dap = pcall(require, "dap")
-- if not dap_status then
--   return
-- end
--
-- for _, language in ipairs { "typescript", "javascript" } do
--   dap.configurations[language] = {
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}",
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-node",
--       request = "attach",
--       name = "Attach",
--       processId = require("dap.utils").pick_process,
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Tests",
--       -- trace = true, -- include debugger info
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--   }
-- end

