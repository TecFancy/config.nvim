local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "html", -- HTML
    "cssls", -- CSS
    "tailwindcss", -- Tailwind CSS
    "tsserver", -- JavaScript, TypeScript
    "volar", -- Vue
    "jsonls", -- JSON
    "eslint", -- EsLint
    "marksman", -- markdown
    "yamlls", -- YAML
    "lua_ls", -- Lua
    "pyright" -- python
  }
})

