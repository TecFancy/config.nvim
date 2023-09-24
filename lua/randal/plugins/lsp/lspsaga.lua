local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end
saga.setup()

-- Breadcrumbs
local winbar_status, winbar = pcall(require, "lspsaga.symbol.winbar")
if not winbar_status then
  return
end
winbar.get_bar()

-- saga.init_lsp_saga({
--   move_in_saga = { prev = "<C-K>", next = "<C-j>" },
--   finder_action_keys = {
--     open = "<CR>"
--   },
--   definition_action_keys = {
--     edit = "<CR>"
--   }
-- })

