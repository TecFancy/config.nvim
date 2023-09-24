-- local status, _ = pcall(vim.cmd, "colorscheme desert") -- vim.cmd("colorscheme desert")
-- local colorscheme = "tokyonight"
local colorscheme = "onedark"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- local status, _ = pcall(vim.cmd, "colorscheme onedark") -- vim.cmd("colorscheme desert")

if not status then
  -- print("Colorscheme not found!")
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

