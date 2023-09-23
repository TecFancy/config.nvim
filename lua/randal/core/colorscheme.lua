local status, _ = pcall(vim.cmd, "colorscheme desert") -- vim.cmd("colorscheme desert")

if not status then
  print("Colorscheme not found!")
  return
end

