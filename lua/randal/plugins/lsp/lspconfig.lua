local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

lspconfig.tsserver.setup {}

local keymap = vim.keymap
local lsp = vim.lsp
local inspect = vim.inspect
local api = vim.api
local bo = vim.bo
local diagnostic = vim.diagnostic

api.nvim_create_autocmd('LspAttach', {
  group = api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    keymap.set('n', 'gf', "<cmd>Lspsaga finder<CR>", opts)
    keymap.set('n', 'gD', lsp.buf.declaration, opts)
    keymap.set('n', 'gd', lsp.buf.definition, opts)
    -- keymap.set('n', 'gd', "<cmd>Lspsaga peek_definition<CR>", opts)
    keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", opts)
    keymap.set('n', '<leader>o', "<cmd>Lspsaga outline<CR>", opts)
    keymap.set('n', 'gi', lsp.buf.implementation, opts)
    keymap.set('n', '<C-k>', lsp.buf.signature_help, opts)
    keymap.set('n', '<leader>wa', lsp.buf.add_workspace_folder, opts)
    keymap.set('n', '<leader>wr', lsp.buf.remove_workspace_folder, opts)
    keymap.set('n', '<leader>wl', function()
      print(inspect(lsp.buf.list_workspace_folders()))
    end, opts)
    keymap.set('n', '<leader>D', lsp.buf.type_definition, opts)
    keymap.set('n', '<leader>rn', lsp.buf.rename, opts)
    keymap.set({ 'n', 'v' }, '<leader>ca', lsp.buf.code_action, opts)
    keymap.set('n', 'gr', lsp.buf.references, opts)
    keymap.set('n', '<leader>f', function()
      lsp.buf.format { async = true }
    end, opts)
    -- keymap.set('n', '[d', diagnostic.goto_prev)
    keymap.set('n', '[d', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    -- keymap.set('n', ']d', diagnostic.goto_next)
    keymap.set('n', ']d', "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  end,
})

-- enable keybinds for available lsp server
-- local on_attach = function(client, bufnr)
--   local keymap = vim.keymap
--   local opts = { noremap = true, silent = true, buffer = bufnr }
--
--   -- set keybinds
--   keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
--   keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
--   keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
--   keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
--   keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
--   keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
--   keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
--   keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
--   keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
--   keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
--
--   if client.name == "tsserver" then
--     keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
--   end
-- end

-- used to enable autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["html"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

lspconfig["cssls"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

-- lspconfig["volar"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

lspconfig["jsonls"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

lspconfig["eslint"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

lspconfig["marksman"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

lspconfig["yamlls"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  -- on_attach = on_attach
})

-- lspconfig["pyright"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach
-- })

typescript.setup({
  server = {
    capabilities = capabilities,
    -- on_attach = on_attach
  }
})

