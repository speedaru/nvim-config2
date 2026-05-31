-- colorscheme (can also be in plugin config if it's a plugin)
vim.cmd.colorscheme("catppuccin-macchiato")

-- Manual fix for PHP function colors if the theme misses them
vim.api.nvim_set_hl(0, "@function.call.php", { link = "Function" })
vim.api.nvim_set_hl(0, "@method.call.php", { link = "Function" })
