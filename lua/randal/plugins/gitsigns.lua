local git_setup, gitsigns = pcall(require, "gitsigns")
if not git_setup then
  return
end

gitsigns.setup()

