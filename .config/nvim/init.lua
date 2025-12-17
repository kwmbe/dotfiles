-- bootstrap lazy.nvim, LazyVim and your plugins

vim.filetype = on
-- vim.g.clipboard = {
--   name = "windows MSYS clipboard",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--   paste = {
--     ["+"] = "cat /dev/clipboard",
--     ["*"] = "cat /dev/clipboard",
--   },
--   cache_enabled = 0,
-- }

if vim.g.neovide then
  -- vim.g.neovide_title_background_color = "#ffffff" .. math.floor(255 * 0.7)
  vim.g.neovide_normal_opacity = 0.0 -- 0.7 or 0
  vim.g.neovide_opacity = 1 -- 0.7 or 1
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_corner_radius = 0.3

  vim.o.guifont = "FiraCode Nerd Font Mono:h11.5:bMedium:#e-subpixelantialias" -- b doesn't work - TODO: figure out how to change weight
  -- vim.o.guifont = "Jetbrains Mono,FiraCode Nerd Font Mono:h10:bMedium:#e-subpixelantialias"
  -- vim.g.neovide_scale_factor = 0.75

  -- vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true })
  -- vim.api.nvim_set_keymap("n", "<sc-v>", 'l"+P', { noremap = true })
  -- vim.api.nvim_set_keymap("v", "<sc-v>", '"+P', { noremap = true })
  -- vim.api.nvim_set_keymap("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
  -- vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>l"+Pli', { noremap = true })
  -- vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })
end

require("config.lazy")

local auto = require("lualine.themes.auto")
auto.normal.c.bg = "none"
auto.insert.c.bg = "none"
auto.visual.c.bg = "none"
auto.command.c.bg = "none"
auto.inactive.c.bg = "none"
auto.terminal.c.bg = "none"
require("lualine").setup({ options = { theme = auto } })
